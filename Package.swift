// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

#if os(macOS)
fileprivate let PLATFORMS: Array<SupportedPlatform> = [.macOS(.v15), .iOS(.v18)]
#endif
#if os(Windows)
fileprivate let PLATFORMS: Array<SupportedPlatform> = [
    .custom("Windows", versionString: "11")
]
#endif

let package = Package(
    name: "Hydrazine",
    platforms: PLATFORMS,
    products: [
        .library(
            name: "Hydrazine",
            targets: ["Hydrazine"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/swiftlang/swift-docc-plugin",
            from: "1.1.0"
        ),
        .package(
            url: "https://github.com/apple/swift-crypto",
            from: "3.10.0"
        )
    ],
    targets: [
        .target(
            name: "Hydrazine",
            dependencies: [
                .product(name: "Crypto", package: "swift-crypto")
            ]
        ),
        .testTarget(
            name: "HydrazineTests",
            dependencies: ["Hydrazine"]
        ),
    ]
)
