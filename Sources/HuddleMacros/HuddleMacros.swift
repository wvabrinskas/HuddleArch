
import HuddleArch

/// A macro that expands the Components initializer
@attached(member, names: arbitrary, conformances: ComponentProviding)
public macro ComponentImpl() = #externalMacro(module: "HuddleMacrosMacros", type: "ComponentImplMacro")
