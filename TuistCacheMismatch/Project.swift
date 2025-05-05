import ProjectDescription

let project = Project(
    name: "TuistCacheMismatch",
    targets: [
        .target(
            name: "TuistCacheMismatch",
            destinations: .iOS,
            product: .app,
            bundleId: "io.tuist.TuistCacheMismatch",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchScreen": [
                        "UIColorName": "",
                        "UIImageName": "",
                    ],
                ]
            ),
            sources: ["TuistCacheMismatch/Sources/**"],
            resources: ["TuistCacheMismatch/Resources/**"],
            dependencies: [
                .external(name: "DatadogProxy"),
                .external(name: "DatadogRUM"),
            ]
        ),
        .target(
            name: "TuistCacheMismatchTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.tuist.TuistCacheMismatchTests",
            infoPlist: .default,
            sources: ["TuistCacheMismatch/Tests/**"],
            resources: [],
            dependencies: [.target(name: "TuistCacheMismatch")]
        ),
    ]
)
