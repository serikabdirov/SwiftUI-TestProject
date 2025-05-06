@preconcurrency
import ProjectDescription
import ProjectDescriptionHelpers

let target = Target.module(
    name: "Platform",
    dependencies: [
        .external(name: "BetterCodable"),
        .external(name: "KeychainAccess"),
        .external(name: "DITranquillity"),
        .external(name: "Pulse"),
        .external(name: "PulseUI"),
        .external(name: "RouteComposer"),
        .external(name: "BottomSheet"),

        .module(name: "Networking"),
    ]
)
let project = Project.module(name: "Platform", targets: [target])
