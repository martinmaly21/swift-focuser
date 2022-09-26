// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Focuser",
    platforms: [
        .iOS(.v12),
    ],
    products: [
        .library(
            name: "Focuser",
            targets: ["Focuser"]),
    ],
    dependencies: [
        .package(url: "https://github.com/martinmaly21/SwiftUI-Introspect.git", .branch("master"))
    ],
    targets: [
        .target(
            name: "Focuser",
            dependencies: ["SwiftUI-Introspect"]),
        .testTarget(
            name: "FocuserTests",
            dependencies: ["Focuser"]),
    ]
)
