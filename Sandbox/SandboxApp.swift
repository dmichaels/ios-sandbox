import SwiftUI
import Utils

@main
struct SandboxApp: App {
    private let settings: Settings = Settings(
        ImageContentView.Config(
            ignoreSafeArea: false,
            background: Colour.gray
        )
    )
    var body: some Scene {
        WindowGroup {
            ImageContentView(config: self.settings.config,
                             imageView: ImageView(settings: self.settings),
                             settingsView: SettingsView(settings: self.settings),
                             toolBarViews: ToolBarViews(settings: self.settings))
        }
    }
}
