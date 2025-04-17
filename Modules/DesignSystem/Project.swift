@preconcurrency
import ProjectDescription
import ProjectDescriptionHelpers

let target = Target.module(
    name: "DesignSystem",
    dependencies: [
        .external(name: "SnapKit"),
        .external(name: "Nuke"),
        .external(name: "NukeUI"),
        .external(name: "NukeExtensions"),
        .module(name: "R"),
        .module(name: "Core"),
        .module(name: "Platform"),
        .external(name: "PhoneNumberKit"),

            .package(product: "ActivityIndicatorView")
    ]
)
let project = Project.module(name: "DesignSystem", targets: [target])
