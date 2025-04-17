@preconcurrency
import ProjectDescription
import ProjectDescriptionHelpers

let target = Target.target(
    name: "R",
    destinations: .iOS,
    product: .framework,
    bundleId: "\(Constants.bundleID)-R",
    deploymentTargets: Constants.deploymentTarget,
    sources: nil,
    resources: [.glob(pattern: .relativeToRoot("Modules/R/Resources/**"))]
)
let project = Project.module(
    name: "R",
    targets: [target],
    resourceSynthesizers: [.assets(), .strings(), .fonts(), .files(extensions: ["json"])]
)
