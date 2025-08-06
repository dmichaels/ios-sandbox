import SwiftUI

@main
struct SandboxApp: App {
    let config: ContentView.Config = ContentView.Config()
    var body: some Scene {
        WindowGroup {
            ContentView(config: self.config,
                        imageView: ImageView(self.config),
                        settingsView: SettingsView(self.config),
                        toolBarView: ToolBarView(self.config))
        }
    }
}
