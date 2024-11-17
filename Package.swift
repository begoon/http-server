// swift-tools-version:6.0
import PackageDescription

let package = Package(
    name: "http-server",
    dependencies: [
        .package(url: "https://github.com/apple/swift-nio.git", from: "2.0.0"),
    ],
    targets: [
        .executableTarget(
            name: "http-server",
            dependencies: [
                .product(name: "NIO", package: "swift-nio"),
                .product(name: "NIOHTTP1", package: "swift-nio"),
            ],
            path: ".",
            sources: ["main.swift"]
        ),
    ]
)
