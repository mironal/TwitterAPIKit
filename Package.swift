// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

#if canImport(CommonCrypto)
let dependencies: [Package.Dependency] = []
let tDependencies: [Target.Dependency] = []
#else
let dependencies: [Package.Dependency] = [.package(url: "https://github.com/apple/swift-crypto.git", from: "2.0.0")]
let tDependencies: [Target.Dependency] = [.product(name: "Crypto", package: "swift-crypto")]
#endif

let package = Package(
    name: "TwitterAPIKit",
    platforms: [
        .macOS(.v10_14),
        .iOS(.v12),
        .tvOS(.v12),
        .watchOS(.v6)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "TwitterAPIKit",
            targets: ["TwitterAPIKit"]),
    ],
    dependencies: dependencies,
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "TwitterAPIKit",
            dependencies: tDependencies),
        .testTarget(
            name: "TwitterAPIKitTests",
            dependencies: ["TwitterAPIKit"]),
    ]
)
