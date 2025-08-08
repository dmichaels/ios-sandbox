import SwiftUI

@main
struct SandboxApp: App {
    let config: ImageContentView.Config = ImageContentView.Config(ignoreSafeArea: false)
    let toolBarView: (ImageContentView.Config) -> AnyView = { config in AnyView(
        HStack {
            Text("APP")
            Spacer()
            Text("FOO")
        }
    )}
    let toolBarViewTrailing: (ImageContentView.Config) -> AnyView = { config in AnyView(
        Button {
            config.showSettingsView()
        } label: {
            Image(systemName: "gearshape")
        }
    )}
    var body: some Scene {
        WindowGroup {
            ImageContentView(config: self.config,
                             imageView: ImageView(self.config),
                             settingsView: SettingsView(self.config),
                             toolBarView: toolBarView,
                             toolBarViewTrailing: toolBarViewTrailing)
        }
    }
}
