import SwiftUI
import Utils

@main
struct SandboxApp: App {
    private let settings: Settings = Settings()
    var body: some Scene {
        WindowGroup {
            ImageContentView(config: self.settings.contentView,
                             imageView: ImageView(settings: self.settings),
                             settingsView: SettingsView(settings: self.settings),
                             toolBarViews: ToolBarViews(settings: self.settings))
        }
    }
}
