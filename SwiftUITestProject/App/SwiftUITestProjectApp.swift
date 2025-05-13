import SwiftUI
import Main
import VIPER

@main
struct SwiftUITestProjectApp: App {
    var body: some Scene {
        WindowGroup {
            VIPERAssembly().build()
        }
    }
}
