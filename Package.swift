// swift-tools-version: 5.10.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "PlusNightMode",
  platforms: [.iOS(.v16), .macOS(.v13), .watchOS(.v9), .visionOS(.v1), .tvOS(.v16), .macCatalyst(.v16)],
  products: [
    // Products define the executables and libraries a package produces, making them visible to other packages.
    .library(
      name: "PlusNightMode",
      targets: ["PlusNightMode"]),
  ],
  dependencies: [
    .package(url: "https://github.com/pointfreeco/swift-snapshot-testing.git", from: "1.17.3"),
//    .package(url: "https://github.com/swiftlang/swift-docc.git", branch: "main"),
  ],
  targets: [
    // Targets are the basic building blocks of a package, defining a module or a test suite.
    // Targets can depend on other targets in this package and products from dependencies.
    .target(
      name: "PlusNightMode",
      dependencies: [
//        .product(name: "SwiftDocC", package: "swift-docc"),
      ],
      resources: [
        .process("Resources/"),
      ],
      swiftSettings: [.enableExperimentalFeature("StrictConcurrency")]
    ),
    .testTarget(
      name: "PlusNightModeTests",
      dependencies: [
        "PlusNightMode",
        .product(name: "SnapshotTesting", package: "swift-snapshot-testing"),
        .product(name: "InlineSnapshotTesting", package: "swift-snapshot-testing")
      ]),
  ]
)
