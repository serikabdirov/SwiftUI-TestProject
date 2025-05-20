import Main
import SwiftUI
import VIPER
import Platform

@main
struct SwiftUITestProjectApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self)
    private var appDelegate

    var body: some Scene {
        WindowGroup {
            TabCoordinatorView(coordinator: TabCoordinatorContainer.shared.tabCoordinator() as! TabCoordinator<TabRouter>)
        }
    }
}
