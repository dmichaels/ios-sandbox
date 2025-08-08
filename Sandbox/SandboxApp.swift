import SwiftUI

@main
struct SandboxApp: App {
    let config: ImageContentView.Config = ImageContentView.Config(ignoreSafeArea: true)
    var body: some Scene {
        WindowGroup {
            ImageContentView(config: self.config,
                             imageView: ImageView(self.config),
                             settingsView: SettingsView(self.config),
                             toolBarView: ToolBarView(self.config))
        }
    }
}
