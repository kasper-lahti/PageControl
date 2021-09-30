// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "PageControl",
    platforms: [.iOS(.v10)],
    products: [
        .library(name: "PageControl", targets: ["PageControl"])
    ],
    targets: [
        .target(name: "PageControl", exclude: ["Info.plist"]),
        .testTarget(name: "PageControlTests", dependencies: ["PageControl"], exclude: ["Info.plist"])
    ]
)
