//swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "GDPR",
    platforms: [
        .macOS(.v10_12),
        .iOS(.v11),
        .tvOS(.v11),
        .watchOS(.v3)
    ],
    products: [
        .library(name: "gdpr-iOS", targets: ["gdpr-iOS"])
    ],
    targets: [
        .target(name: "gdpr-iOS", dependencies: [], path: "gdpr-iOS/")
    ],
    swiftLanguageVersions: [.v5]
)
