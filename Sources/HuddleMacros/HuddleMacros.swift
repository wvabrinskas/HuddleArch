
import HuddleArch

/// A macro that expands the Components initializer
@attached(member, names: arbitrary, conformances: ComponentProviding)
public macro ComponentImpl() = #externalMacro(module: "HuddleMacrosMacros", type: "ComponentImplMacro")

/// A macro that adds the conformance for `ViewBuilding` for a particular builder
/// router: The Routing type for the specific builder
/// component: The ViewComponent type for the specific builder.
@attached(member, names: arbitrary, conformances: ViewBuilding)
public macro Building(_ router: Routing.Type,
                      _ component: ViewComponent.Type) = #externalMacro(module: "HuddleMacrosMacros", type: "BuildingImplMacro")
