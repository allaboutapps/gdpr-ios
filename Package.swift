// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "GDPR",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(name: "GDPR", targets: ["GDPR"])
    ],
    targets: [
        .target(name: "GDPR", path: "GDPR", exclude: ["Info.plist"], resources: [.process("strings")])
    ],
    swiftLanguageVersions: [.v5]
)
