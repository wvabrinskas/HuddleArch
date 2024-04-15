// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
import CompilerPluginSupport

let package = Package(
    name: "HuddleArch",
    platforms: [ .iOS(.v13),
                 .tvOS(.v13),
                 .watchOS(.v6),
                 .macOS(.v11)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "HuddleArch",
            targets: ["HuddleArch"]),
        .library(
            name: "HuddleMacros",
            targets: ["HuddleMacros"]
        ),
        .executable(
            name: "HuddleMacrosClient",
            targets: ["HuddleMacrosClient"]
        ),
    ],
    dependencies: [
      .package(url: "https://github.com/apple/swift-syntax.git", from: "509.0.0"),
    ],
    targets: [
      // Targets are the basic building blocks of a package, defining a module or a test suite.
      // Targets can depend on other targets in this package and products from dependencies.
      .target(name: "HuddleArch"),
      
      .target(name: "HuddleMacros", dependencies: ["HuddleMacrosMacros"]),
      
      .macro(
        name: "HuddleMacrosMacros",
        dependencies: [
          .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
          .product(name: "SwiftCompilerPlugin", package: "swift-syntax")
        ]
      ),
      
      .executableTarget(name: "HuddleMacrosClient", dependencies: ["HuddleMacros", "HuddleArch"]),
      
      .testTarget(
        name: "HuddleArchTests",
        dependencies: ["HuddleArch"]),
      
      .testTarget(
          name: "HuddleMacrosTests",
          dependencies: [
              "HuddleMacrosMacros",
              .product(name: "SwiftSyntaxMacrosTestSupport", package: "swift-syntax"),
          ]
      ),
    ]
)
