@preconcurrency
import ProjectDescription
import ProjectDescriptionHelpers

let settings = Settings.withCustomConfigurations()
let schemes = [
    Scheme.scheme(name: "Dev", targetName: Constants.name),
    Scheme.scheme(name: "Stage", targetName: Constants.name),
    Scheme.scheme(name: "Prod", targetName: Constants.name),
    Scheme.scheme(name: "Mock", targetName: Constants.name),
]

let appTarget = Target.target(
    name: Constants.name,
    destinations: [.iPhone],
    product: .app,
    productName: Constants.name,
    bundleId: Constants.bundleID,
    deploymentTargets: Constants.deploymentTarget,
    infoPlist: .file(path: "\(Constants.name)/App/Info.plist"),
    sources: ["\(Constants.name)/**/*.swift"],
    resources: [
        "\(Constants.name)/Resources/**",
    ],
    copyFiles: nil,
    headers: nil,
    scripts: [],
    dependencies: [
        // External
        .external(name: "DITranquillity"),
        .external(name: "Alamofire"),
        .external(name: "SnapKit"),
        .external(name: "RouteComposer"),
        .external(name: "Factory"),

        .module(name: "Platform"),
        .module(name: "DesignSystem"),

    ],
    settings: settings
)

let project = Project(
    name: Constants.name,
    organizationName: Constants.organizationName,
    options: .options(
        automaticSchemesOptions: .disabled,
        developmentRegion: Constants.developmentRegion,
        textSettings: .textSettings(usesTabs: false, indentWidth: 4, wrapsLines: true),
        xcodeProjectName: Constants.name
    ),
    packages: [
        .remote(url: "https://github.com/exyte/ActivityIndicatorView.git", requirement: .upToNextMajor(from: "1.2.0")),
    ],
    settings: settings,
    targets: [appTarget],
    schemes: schemes,
    fileHeaderTemplate: nil,
    additionalFiles: [
        .glob(pattern: .relativeToRoot("Configurations/Config.xcconfig")),
    ],
    resourceSynthesizers: [.strings(), .assets()]
)
