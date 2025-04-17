import ProjectDescription

let project = Project(
    name: "SwiftUITestProject",
    targets: [
        .target(
            name: "SwiftUITestProject",
            destinations: .iOS,
            product: .app,
            bundleId: "io.tuist.SwiftUITestProject",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchStoryboardName": "LaunchScreen.storyboard",
                ]
            ),
            sources: ["SwiftUITestProject/Sources/**"],
            resources: ["SwiftUITestProject/Resources/**"],
            dependencies: []
        ),
        .target(
            name: "SwiftUITestProjectTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.tuist.SwiftUITestProjectTests",
            infoPlist: .default,
            sources: ["SwiftUITestProject/Tests/**"],
            resources: [],
            dependencies: [.target(name: "SwiftUITestProject")]
        ),
    ]
)
