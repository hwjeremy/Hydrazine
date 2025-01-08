// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Hydrazine",
    platforms: [.macOS(.v15), .iOS(.v18)],
    products: [
        .library(
            name: "Hydrazine",
            targets: ["Hydrazine"]),
    ],
    dependencies: [
        // other dependencies
        .package(url: "https://github.com/swiftlang/swift-docc-plugin", from: "1.1.0"),
    ],
    targets: [
        .target(
            name: "Hydrazine"
        ),
        .testTarget(
            name: "HydrazineTests",
            dependencies: ["Hydrazine"]
        ),
    ]
)
