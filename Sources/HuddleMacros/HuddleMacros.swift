
import HuddleArch

/// A macro that expands the Components initializer
@attached(member, names: arbitrary, conformances: ComponentProviding)
public macro ComponentImpl() = #externalMacro(module: "HuddleMacrosMacros", type: "ComponentImplMacro")

/// A macro that expands the Components initializer
@attached(member, names: arbitrary, conformances: ViewBuilding)
public macro Building(_ router: Routing.Type,
                      _ component: ViewComponent.Type) = #externalMacro(module: "HuddleMacrosMacros", type: "BuildingImplMacro")
