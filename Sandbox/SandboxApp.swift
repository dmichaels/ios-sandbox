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
                // toolBarViews: ToolBarViewLeading(self.config), ToolBarViewTrailing(self.config))
                // toolBarViews: ToolBarViews3(config: config)
                toolBarViews: ImageContentView.ToolBarView3(config,
                    ImageContentView.ToolBarViewBuilder { _ in
                        Text("Home3")
                    },
                    ImageContentView.ToolBarViewBuilder { config in
                        Button { config.showSettingsView() } label: { Image(systemName: "gearshape") }
                    }
                )
            )
        }
    }

    func ToolBarViews(config: ImageContentView.Config) -> [ImageContentView.ToolBarViewable] {
        return [
            ImageContentView.ToolBarViewBuilder { _ in
                Text("hOMe")
            },
            ImageContentView.ToolBarViewBuilder { config in
                Button { config.showSettingsView() } label: { Image(systemName: "gearshape") }
            }
        ].map { item in item(config) }
    }

    func ToolBarViews2(config: ImageContentView.Config) -> [AnyView] {
        return ImageContentView.ToolBarView([
            ImageContentView.ToolBarViewBuilder { _ in
                Text("Home2")
            },
            ImageContentView.ToolBarViewBuilder { config in
                Button { config.showSettingsView() } label: { Image(systemName: "gearshape") }
            }
        ], config)
    }

    func ToolBarViews3(config: ImageContentView.Config) -> [AnyView] {
        return ImageContentView.ToolBarView3(config,
            ImageContentView.ToolBarViewBuilder { _ in
                Text("Home3")
            },
            ImageContentView.ToolBarViewBuilder { config in
                Button { config.showSettingsView() } label: { Image(systemName: "gearshape") }
            }
        )
    }
}
