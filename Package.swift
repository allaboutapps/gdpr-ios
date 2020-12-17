// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "gdpr-ios",
    platforms: [
        .macOS(.v10_12),
        .iOS(.v11),
        .tvOS(.v11),
        .watchOS(.v3)
    ],
    products: [
        .library(name: "gdpr-ios", targets: ["gdpr-ios"])
    ],
    targets: [
        .target(name: "gdpr-ios", dependencies: [], path: "gdpr-ios/")
    ],
    swiftLanguageVersions: [.v5]
)
