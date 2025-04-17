@preconcurrency
import ProjectDescription

public extension Target {
    static func featureModule(
        name: String,
        dependencies: [TargetDependency] = []
    ) -> Target {
        .target(
            name: name,
            destinations: .iOS,
            product: .framework,
            bundleId: "\(Constants.bundleID)-\(name)",
            deploymentTargets: Constants.deploymentTarget,
            sources: [
                .glob(.relativeToRoot("Modules/FeatureModules/\(name)/Sources/**/*.swift"))
            ],
            dependencies: dependencies + [
                .module(name: "DesignSystem"),
                .module(name: "Platform"),
            ]
        )
    }

    static func module(name: String, dependencies: [TargetDependency] = [], includeResources: Bool = false) -> Target {
        var resources: ResourceFileElements? = nil
        if includeResources {
            resources = [
                .glob(pattern: .relativeToRoot("Modules/\(name)/Resources/**")),
            ]
        }

        return .target(
            name: name,
            destinations: .iOS,
            product: .framework,
            bundleId: "\(Constants.bundleID)-\(name)",
            deploymentTargets: Constants.deploymentTarget,
            sources: [.glob(.relativeToRoot("Modules/\(name)/Sources/**/*.swift"))],
            resources: resources,
            dependencies: dependencies
        )
    }
}
