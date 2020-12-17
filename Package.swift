// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "GDPR",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(name: "GDPR", targets: ["GDPR"])
    ],
    targets: [
        .target(name: "GDPR", dependencies: [], path: "GDPR/", exclude: ["Info.plist"])
    ],
    swiftLanguageVersions: [.v5]
)
