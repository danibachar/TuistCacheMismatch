// swift-tools-version: 6.0
import PackageDescription

#if TUIST
    import struct ProjectDescription.PackageSettings

    let packageSettings = PackageSettings(
        // Customize the product types for specific package product
        // Default is .staticFramework
        // productTypes: ["Alamofire": .framework,]
        productTypes: [:]
    )
#endif

let package = Package(
    name: "TuistCacheMismatch",
    dependencies: [
        .package(url: "https://github.com/danibachar/DatadogProxy.git", exact: "1.0.1"),
        .package(url: "https://github.com/DataDog/dd-sdk-ios.git", exact: "2.26.0"),
    ]
)
