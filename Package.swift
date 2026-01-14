// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WWSwiftUI_Charts",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(name: "WWSwiftUI_Charts", targets: ["WWSwiftUI_Charts"]),
    ],
    dependencies: [
        .package(url: "https://github.com/William-Weng/WWSwiftUI_MultiDatePicker", from: "1.2.1")
    ],
    targets: [
        .target(name: "WWSwiftUI_Charts", dependencies: ["WWSwiftUI_MultiDatePicker"], resources: [.copy("Privacy")]),
    ],
    swiftLanguageVersions: [
        .v5
    ]
)
