@preconcurrency
import ProjectDescription
import ProjectDescriptionHelpers

let target = Target.module(
    name: "Core",
    dependencies: [
        .external(name: "RxSwift"),
        .external(name: "RxCocoa"),
        .external(name: "RxRelay")
    ]
)
let project = Project.module(name: "Core", targets: [target])
