import ProjectDescription
import ProjectDescriptionHelpers

private let moduleAttribute: Template.Attribute = .required("module")
private let nameAttribute: Template.Attribute = .required("name")
private let yearAttr: Template.Attribute = .optional("year", default: .init(stringLiteral: TemplateHelper.year))

let featureSUI = Template(
    description: "Template for generate feature modules",
    attributes: [
        moduleAttribute,
        nameAttribute,
        .optional("author", default: "")
    ],
    items: [
        .file(
            path: "Modules/FeatureModules/\(moduleAttribute)/Sources/Scenes/\(nameAttribute)/\(nameAttribute)DIPart.swift",
            templatePath: "../feature/DIPart.stencil"
        ),
        .file(
            path: "Modules/FeatureModules/\(moduleAttribute)/Sources/Scenes/\(nameAttribute)/\(nameAttribute)Factory.swift",
            templatePath: "../feature/Factory.stencil"
        ),
        .file(
            path: "Modules/FeatureModules/\(moduleAttribute)/Sources/Scenes/\(nameAttribute)/\(nameAttribute)Router.swift",
            templatePath: "../feature/Router.stencil"
        ),
        .file(
            path: "\(Constants.name)/Routers/\(moduleAttribute)/\(nameAttribute)RouterImpl.swift",
            templatePath: "../feature/RouterImpl.stencil"
        ),
        .file(
            path: "Modules/FeatureModules/\(moduleAttribute)/Sources/Scenes/\(nameAttribute)/\(nameAttribute)View.swift",
            templatePath: "ViewSUI.stencil"
        ),
        .file(
            path: "Modules/FeatureModules/\(moduleAttribute)/Sources/Scenes/\(nameAttribute)/\(nameAttribute)ViewController.swift",
            templatePath: "ViewControllerSUI.stencil"
        ),
        .file(
            path: "Modules/FeatureModules/\(moduleAttribute)/Sources/Scenes/\(nameAttribute)/\(nameAttribute)ViewModel.swift",
            templatePath: "../feature/ViewModel.stencil"
        ),
    ]
)
