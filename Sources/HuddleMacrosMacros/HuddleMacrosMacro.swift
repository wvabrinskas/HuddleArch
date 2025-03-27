import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import SwiftParser

public struct BuildingImplMacro: MemberMacro {
  public static func expansion(of node: AttributeSyntax,
                               providingMembersOf declaration: some DeclGroupSyntax,
                               in context: some MacroExpansionContext) throws -> [DeclSyntax] {
    
    guard let protocolDecl = declaration.as(StructDeclSyntax.self),
          let firstAttribute = protocolDecl.attributes.first?.as(AttributeSyntax.self),
          let router = firstAttribute.arguments?.as(LabeledExprListSyntax.self)?.first?.expression.as(DeclReferenceExprSyntax.self)?.baseName.text,
          let componentIndex = firstAttribute.arguments?.as(LabeledExprListSyntax.self)?.index(at: 1),
          let component = firstAttribute.arguments?.as(LabeledExprListSyntax.self)?[componentIndex].expression.as(DeclReferenceExprSyntax.self)?.baseName.text else {
      return []
    }
    
    let stringLiteral = """
                         public static func buildRouter(component: \(component)) -> \(router) {
                           \(router)(component: component)
                         }           
                        """
    
    let decl = DeclSyntax(stringLiteral: stringLiteral)
    return [decl]
  }
}

public struct ComponentImplMacro: MemberMacro, ExtensionMacro {
  public static func expansion(of node: SwiftSyntax.AttributeSyntax,
                               
                               attachedTo declaration: some SwiftSyntax.DeclGroupSyntax,
                               providingExtensionsOf type: some SwiftSyntax.TypeSyntaxProtocol,
                               conformingTo protocols: [SwiftSyntax.TypeSyntax],
                               in context: some SwiftSyntaxMacros.MacroExpansionContext) throws -> [SwiftSyntax.ExtensionDeclSyntax] {

    let extensionDecl = try ExtensionDeclSyntax("""
                                                extension \(type.trimmed): CustomReflectable {
                                                }
                                                """)
    return [extensionDecl]
  }
  
  public static func expansion(of node: AttributeSyntax,
                               providingMembersOf declaration: some DeclGroupSyntax,
                               in context: some MacroExpansionContext) throws -> [DeclSyntax] {
    
    guard let protocolDecl = declaration.as(ClassDeclSyntax.self) else {
      // throw error
      return []
    }
    
    let members = protocolDecl.memberBlock.members
  
    var initDecls: [MemberBlockItemSyntax] = []
    
    let functionSignatureParameters: [FunctionParameterSyntax] = [.init(attributes: .init([]),
                                                                        modifiers: .init([]),
                                                                        firstName: .identifier("parent"),
                                                                        colon: .colonToken(),
                                                                        type: IdentifierTypeSyntax(name: .identifier("Component")))]
    var codeBlockItemSyntax: [CodeBlockItemSyntax] = []
    
    var properties: [String] = []

    for m in members {
      guard let variable = m.decl.as(VariableDeclSyntax.self),
            let variableDec = variable.bindings.first else {
        continue
      }
      
      
      if variableDec.accessorBlock == nil {
        properties.append("\"\(variableDec.pattern.description)\": \(variableDec.pattern.description)")

        if variableDec.initializer == nil {
          // create init function
          let selfExpression = DeclReferenceExprSyntax(baseName: .keyword(.`self`))
          let calledExpression = MemberAccessExprSyntax(base: selfExpression,
                                                        period: .periodToken(),
                                                        declName: DeclReferenceExprSyntax(baseName: .identifier(variableDec.pattern.description)))
          
          let equals = AssignmentExprSyntax(equal: .equalToken())
          
          let setExpression = DeclReferenceExprSyntax(baseName: .identifier("parent"))
          let setCalledExpression = MemberAccessExprSyntax(base: setExpression,
                                                           period: .periodToken(),
                                                           declName: DeclReferenceExprSyntax(baseName: .identifier(variableDec.pattern.description)))
          
          let wholeSetExpression = SequenceExprSyntax(elements: .init(arrayLiteral: .init(calledExpression),
                                                                      .init(equals),
                                                                      .init(setCalledExpression)))
          
          
          codeBlockItemSyntax.append(.init(item: .expr(.init(wholeSetExpression))))
        }

      } else {
        // lazy access on blocks and lazy inits
        properties.append("\"\(variableDec.pattern.description)\": { [weak self] in \n guard let self else { fatalError(\"Mirror failed to find self\") } \n return \(variableDec.pattern.description) } ")
      }
    }
    
    let superExpression = SuperExprSyntax(superKeyword: .keyword(.super))
    let calledExpression = MemberAccessExprSyntax(base: superExpression, period: .periodToken(), declName: DeclReferenceExprSyntax(baseName: .keyword(.`init`)))
    
    let itemExpression = FunctionCallExprSyntax(calledExpression: calledExpression,
                                                leftParen: .leftParenToken(),
                                                arguments: LabeledExprListSyntax([LabeledExprSyntax(label: .identifier("parent"),
                                                                                                    colon: .colonToken(),
                                                                                                    expression: DeclReferenceExprSyntax(baseName: .identifier("parent")))]),
                                                rightParen: .rightParenToken(),
                                                additionalTrailingClosures: .init([]))
    
    let codeBlockSuperCall = CodeBlockItemSyntax(item: .expr(.init(itemExpression)))
    
    codeBlockItemSyntax.append(codeBlockSuperCall)
    
    let initFunctionDecl = MemberBlockItemSyntax(decl: InitializerDeclSyntax(attributes: .init([]),
                                                                             modifiers: .init([DeclModifierSyntax(name: .keyword(SwiftSyntax.Keyword.public)),
                                                                                               DeclModifierSyntax(name: .keyword(SwiftSyntax.Keyword.override))]),
                                                                             initKeyword: .keyword(.`init`),
                                                                             signature: .init(parameterClause: .init(leftParen: .leftParenToken(),
                                                                                                                     parameters: .init(functionSignatureParameters), //FunctionParameterListSyntax
                                                                                                                     rightParen: .rightParenToken())),
                                                                             body: .init(leftBrace: .leftBraceToken(),
                                                                                         statements: .init(codeBlockItemSyntax), // CodeBlockItemSyntax
                                                                                         rightBrace: .rightBraceToken())))
    
    initDecls.append(initFunctionDecl)

    let joined = properties.joined(separator: ", \n")

    let mirrorConformanceString = """
                                     public lazy var customMirror: Mirror = {
                                         return Mirror(self,
                                                       children: [
                                                        \(joined)
                                                      ])
                                     }()
                                  """
    
    let parsed = Parser.parse(source: mirrorConformanceString)
    
    let decl =  parsed.statements.compactMap { statement in
      statement.item.as(VariableDeclSyntax.self)
    }.first
    
    var decls = [DeclSyntax(decl)].compactMap { $0 }
    
    decls.append(contentsOf: initDecls.map { $0.decl })
    return decls
  }
}

@main
struct HuddleMacrosPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
      ComponentImplMacro.self,
      BuildingImplMacro.self
    ]
}
