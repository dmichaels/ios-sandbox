import SwiftUI

@main
struct SandboxApp: App {
    var config: ContentView.Config = ContentView.Config()
    var body: some Scene {
        WindowGroup {
            ContentView(imageView: ImageView(config), settingsView: SettingsView())
                .environmentObject(config)
        }
    }
}
