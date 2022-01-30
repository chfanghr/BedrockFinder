// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BedrockFinder",
    platforms: [
            .macOS(.v10_15),
            .iOS(.v13),
            .watchOS(.v6),
            .tvOS(.v13),
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "BedrockFinder",
            targets: ["BedrockFinder"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/apple/swift-crypto.git", "1.0.0" ..< "3.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "BedrockFinder",
            dependencies: [ .product(name: "Crypto", package: "swift-crypto") ]),
        .testTarget(
            name: "BedrockFinderTests",
            dependencies: ["BedrockFinder"]),
    ]
)
