@preconcurrency
import ProjectDescription
import ProjectDescriptionHelpers

let target = Target.featureModule(
    name: "ParameterModule",
    dependencies: []
)
let project = Project.module(name: "ParameterModule", targets: [target])