import SwiftUI

@main
struct SandboxApp: App {
    private let config: ImageContentView.Config = ImageContentView.Config(ignoreSafeArea: false)
    var body: some Scene {
        WindowGroup {
            ImageContentView(config: self.config,
                             imageView: ImageView(self.config),
                             settingsView: SettingsView(self.config),
                             toolBarViews: ToolBarView(self.config))
        }
    }
}
