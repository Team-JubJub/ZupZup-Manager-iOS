import ProjectDescription
import ProjectDescriptionHelpers

// MARK: - Project

// Creates our project using a helper function defined in ProjectDescriptionHelpers
let project = Project(
    name: "ZupZupManager",
    organizationName: "ZupZup",
    options: .options(
        disableBundleAccessors: true,
        disableSynthesizedResourceAccessors: true
    ),
    packages: [
        .remote(url: "https://github.com/Alamofire/Alamofire.git", requirement: .upToNextMajor(from: "5.0.0")),
        .remote(url: "https://github.com/onevcat/Kingfisher.git", requirement: .upToNextMajor(from: "7.5.0")),
        .remote(url: "https://github.com/pointfreeco/swift-composable-architecture.git", requirement: .upToNextMajor(from: "0.5.0")),
        .remote(url: "https://github.com/firebase/firebase-ios-sdk", requirement: .upToNextMajor(from: "10.0.0"))
    ],
    settings: .settings(
        base: ["OTHER_LDFLAGS" : ["$(OTHER_LDFLAGS) -ObjC", "-all_load"]],
        configurations: [
            .debug(name: .debug),
            .release(name: .release)
        ],
        defaultSettings: .recommended
    ),
    targets: [
        Target(
            name: "ZupZupManager",
            platform: .iOS,
            product: .app,
            bundleId: "com.ZupZupManager",
            deploymentTarget: .iOS(targetVersion: "16.0", devices: .iphone),
            infoPlist: .file(path: "SupportingFiles/ZupZupManager-Info.plist"),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            entitlements: "SupportingFiles/ZupZupManager.entitlements",
            scripts: [.SwiftLintShell],
            dependencies: [
                .package(product: "Alamofire"),
                .package(product: "Kingfisher"),
                .package(product: "ComposableArchitecture"),
                .package(product: "FirebaseFirestore"),
                .package(product: "FirebaseFirestoreSwift"),
                .package(product: "FirebaseMessaging")
                
            ]
        ),
        Target(
            name: "ZupZupManagerTests",
            platform: .iOS,
            product: .unitTests,
            bundleId: "com.ZupZupManager.ZupZupManagerTests",
            infoPlist: .default,
            sources: ["Tests/**"],
            dependencies: [.target(name: "ZupZupManager")]
        )
    ]
)
