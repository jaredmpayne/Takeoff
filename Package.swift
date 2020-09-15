// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "Takeoff",
    platforms: [
        .macOS(.v11),
        .iOS(.v14)
    ],
    products: [
        .library(name: "Takeoff", targets: ["Takeoff"])
    ],
    dependencies: [],
    targets: [
        .target(name: "Takeoff", dependencies: [])
    ]
)
