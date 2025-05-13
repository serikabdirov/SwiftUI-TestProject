@preconcurrency
import ProjectDescription
import ProjectDescriptionHelpers

let target = Target.featureModule(
    name: "VIPER",
    dependencies: []
)
let project = Project.module(name: "VIPER", targets: [target])