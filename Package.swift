// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "GDPR",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(name: "GDPR", targets: ["GDPR"])
    ],
    targets: [
        .target(name: "GDPR")
    ],
    swiftLanguageVersions: [.v5]
)
