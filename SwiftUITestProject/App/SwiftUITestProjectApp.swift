import Main
import SwiftUI
import VIPER

@main
struct SwiftUITestProjectApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self)
    private var appDelegate

    var body: some Scene {
        WindowGroup {
            VIPERAssembly().build()
        }
    }
}
