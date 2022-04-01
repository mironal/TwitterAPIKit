// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "BuildTools",
    platforms: [.macOS(.v10_11)],
    dependencies: [
        .package(url: "https://github.com/apple/swift-format", from: "0.50600.1"),
    ],
    targets: [.target(name: "BuildTools", path: "")]
)
