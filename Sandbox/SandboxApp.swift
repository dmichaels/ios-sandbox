import SwiftUI

@main
struct SandboxApp: App {
    let config: ImageContentView.Config = ImageContentView.Config(ignoreSafeArea: false)
    let toolBarView: (ImageContentView.Config) -> AnyView = { config in AnyView(
        HStack {
            Text("APP")
            Spacer()
            Text("FOO")
            Button {
                config.showSettingsView()
            } label: {
                Image(systemName: "gearshape")
            }
        }
    )}
    /*
    let makeToolbar: (ImageContentView.Config) -> YToolBarView<some ToolbarContent> = { cfg in
        YToolBarView(cfg) {
            // Left side
            ToolbarItem(placement: .navigationBarLeading) {
                HStack {
                    Text("APP")
                    Text("FOO")
                }
            }
            // Right side
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    cfg.showSettingsView()
                } label: {
                    Image(systemName: "gearshape")
                }
            }
            // (Optional) middle slot
            // ToolbarItem(placement: .principal) { Text("Center") }
        }
    }
    */
    var body: some Scene {
        WindowGroup {
            ImageContentView(config: self.config,
                             imageView: ImageView(self.config),
                             settingsView: SettingsView(self.config),
                             toolBarView: toolBarView)
        }
    }
}
