@preconcurrency
import ProjectDescription
import ProjectDescriptionHelpers

let target = Target.featureModule(
    name: "Main",
    dependencies: []
)
let project = Project.module(name: "Main", targets: [target])
