// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "swiftui-hosting-transitions",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "MatchedTransitions",
            targets: ["MatchedTransitions"]
        ),
    ],
    targets: [
        .target(name: "MatchedTransitions")
    ]
)
