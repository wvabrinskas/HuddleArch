import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

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

public struct ComponentImplMacro: MemberMacro {
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
    
    members.forEach { m in
      if let variable = m.decl.as(VariableDeclSyntax.self),
         let variableDec = variable.bindings.first,
         variableDec.accessorBlock == nil,
         variableDec.initializer == nil { // dont add for pre defined variables already
        
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

    return initDecls.map { $0.decl }
  }
}

@main
struct HuddleMacrosPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
      ComponentImplMacro.self,
      BuildingImplMacro.self
    ]
}
