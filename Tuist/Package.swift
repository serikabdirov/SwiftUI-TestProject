// swift-tools-version: 5.9
@preconcurrency
import PackageDescription

#if TUIST
    @preconcurrency
    import ProjectDescription
    import ProjectDescriptionHelpers

    let packageSettings = PackageSettings(
        productTypes: [
            "Alamofire": .framework,
            "RxSwift": .framework,
            "SnapKit": .framework,
            "DITranquillity": .framework,
            "RouteComposer": .framework,
            "Nuke": .framework,
            "NukeUI": .framework,
            "NukeExtensions": .framework,
            "BetterCodable": .framework,
            "KeychainAccess": .framework,
            "PhoneNumberKit": .framework,
            "IQKeyboardManager": .framework,
            "Pulse": .framework,
            "Lottie": .framework,
            "BottomSheet": .framework,
            "Factory": .framework,
        ],
        baseSettings: .withCustomConfigurations()
    )
#endif

let package = Package(
    name: "BallAppNew",
    dependencies: [
        .package(
            url: "https://github.com/Alamofire/Alamofire",
            from: "5.10.2"
        ),
        .package(
            url: "https://github.com/ReactiveX/RxSwift.git",
            from: "6.7.0"
        ),
        .package(
            url: "https://github.com/SnapKit/SnapKit",
            from: "5.7.0"
        ),
        .package(
            url: "https://github.com/ivlevAstef/DITranquillity",
            from: "4.6.0"
        ),
        .package(
            url: "https://github.com/ekazaev/route-composer",
            from: "2.10.2"
        ),
        .package(
            url: "https://github.com/kean/Nuke",
            from: "12.8.0"
        ),
        .package(
            url: "https://github.com/marksands/BetterCodable",
            from: "0.4.0"
        ),
        .package(
            url: "https://github.com/kishikawakatsumi/KeychainAccess.git",
            from: "4.2.2"
        ),

        .package(
            url: "https://github.com/hackiftekhar/IQKeyboardManager.git",
            from: "8.0.0"
        ),
        .package(
            url: "https://github.com/marmelroy/PhoneNumberKit",
            from: "4.0.0"
        ),
        .package(
            url: "https://github.com/kean/Pulse",
            from: "5.1.0"
        ),
        .package(
            url: "https://github.com/joomcode/BottomSheet",
            from: "2.0.5"
        ),
        .package(
            url: "https://github.com/hmlongco/Factory",
            from: "2.4.0"
        ),
    ]
)
