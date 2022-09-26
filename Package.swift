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
        .package(name: "Introspect", url: "https://github.com/martinmaly21/SwiftUI-Introspect.git", revision: "1f68e763c16965b28a9c51d35036e365174b3085")
    ],
    targets: [
        .target(
            name: "Focuser",
            dependencies: ["Introspect"]),
        .testTarget(
            name: "FocuserTests",
            dependencies: ["Focuser"]),
    ]
)
