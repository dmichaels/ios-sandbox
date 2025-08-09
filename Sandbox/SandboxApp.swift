import SwiftUI

@main
struct SandboxApp: App {
    private let config: ImageContentView.Config = ImageContentView.Config(ignoreSafeArea: false)
    var body: some Scene {
        WindowGroup {
            ImageContentView(
                config: self.config,
                imageView: ImageView(self.config),
                settingsView: SettingsView(self.config),
                toolBarViews: ImageContentView.ToolBarView(self.config,
                    ToolBarViewItems
                /*
                    ImageContentView.ToolBarItem { _ in
                        Text("Home")
                    },
                    x,
                    ImageContentView.ToolBarItem { config in
                        Button { config.showSettingsView() } label: { Image(systemName: "gearshape") }
                    }
                    */
                )
            )
        }
    }

    // FYI: Alternatively to above could defined toolbar items here like this.
    //
    let ToolBarViewItems: [ImageContentView.ToolBarItemBuilder] = [
        ImageContentView.ToolBarItem { _ in
            Text("Home")
        },
        ImageContentView.ToolBarItem { config in
            Button {
                config.showSettingsView()
            }
            label: {
                Image(systemName: "gearshape")
            }
        }
    ]
}
