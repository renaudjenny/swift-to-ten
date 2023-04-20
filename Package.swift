// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swift-to-ten",
    platforms: [
        .iOS(.v14),
        .macOS(.v11),
    ],
    products: [
        .library(name: "SwiftToTen", targets: ["SwiftToTen"]),
        .library(name: "SwiftToTenDependency", targets: ["SwiftToTenDependency"]),
    ],
    dependencies: [
        .package(url: "https://github.com/johnno1962/SwiftRegex5", from: "5.2.1"),
        .package(url: "https://github.com/pointfreeco/swift-dependencies", from: "0.4.1"),
    ],
    targets: [
        .target(
            name: "SwiftToTen",
            dependencies: [
                .product(name: "SwiftRegex", package: "SwiftRegex5"),
            ]
        ),
        .testTarget(name: "SwiftToTenTests", dependencies: ["SwiftToTen"]),
        .target(
            name: "SwiftToTenDependency",
            dependencies: [
                .product(name: "Dependencies", package: "swift-dependencies"),
                "SwiftToTen",
            ]
        ),
    ]
)
