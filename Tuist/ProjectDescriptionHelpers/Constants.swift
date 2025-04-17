@preconcurrency
import ProjectDescription

public enum Constants {}

public extension Constants {
    static let name = "SwiftUITestProject"
    static let bundleID = "ru.spider.SwiftUITestProject"
    static let organizationName = "Spider Group"
    static let developmentRegion = "ru"
    static let deploymentTarget: DeploymentTargets = .iOS("17.0")
}
