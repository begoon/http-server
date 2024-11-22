// swift-tools-version:6.0
import PackageDescription

let package = Package(
    name: "http-server",
	 platforms: [.macOS(.v10_15)],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "4.0.0"),
    ],
    targets: [
        .executableTarget(
            name: "http-server",
            dependencies: [
                .product(name: "Vapor", package: "vapor"),
            ],
            path: ".",
            sources: ["main.swift"]
        ),
    ]
)
