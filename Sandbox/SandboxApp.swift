import SwiftUI

@main
struct SandboxApp: App {

    private let config: ImageContentView.Config = ImageContentView.Config(ignoreSafeArea: false)

    var body: some Scene {
        WindowGroup {
            ImageContentView(config: self.config,
                             imageView: ImageView(self.config),
                             settingsView: SettingsView(self.config),
                             // toolBarViews: ToolBarViewLeading(self.config), ToolBarViewTrailing(self.config))
                             toolBarViews: ToolBarViews(config: config))
        }
    }

/*
    private let ToolBarViewLeading: ImageContentView.ToolBarViewMaker = { config in
        ImageContentView.ToolBarViewable(
            Text("Home")
        )
    }

    private var ToolBarViewTrailing: ImageContentView.ToolBarViewMaker = { config in
        ImageContentView.ToolBarViewable(
            Button { config.showSettingsView() } label: { Image(systemName: "gearshape") }
        )
    }

    func ToolBarView(config: ImageContentView.Config) -> [ImageContentView.ToolBarViewable] {
        let ToolBarViewLeading: ImageContentView.ToolBarViewMaker = { config in
            ImageContentView.ToolBarViewable(
                Text("Home")
            )
        }
        let ToolBarViewTrailing: ImageContentView.ToolBarViewMaker = { config in
            ImageContentView.ToolBarViewable(
                Button { config.showSettingsView() } label: { Image(systemName: "gearshape") }
            )
        }
        return [
            ToolBarViewLeading(config),
            ToolBarViewTrailing(config)
        ]
    }
*/

/*
    func ToolBarViewBuilders(config: ImageContentView.Config) -> [ImageContentView.ToolBarViewMaker] {
        let x = SandboxApp.tb { _ in
            Text("home")
        }
        let y = SandboxApp.tb { config in
            Button { config.showSettingsView() } label: { Image(systemName: "gearshape") }
        }
let z = y(config)
        return [
            x,
            y,
            SandboxApp.tb { config in
                Button { config.showSettingsView() } label: { Image(systemName: "gearshape") }
            }
        ]
    }
*/

    func ToolBarViews(config: ImageContentView.Config) -> [ImageContentView.ToolBarViewable] {
/*
        let x = ImageContentView.ToolBarViewBuilder { _ in
            Text("hOMe")
        }
        let y = ImageContentView.ToolBarViewBuilder { config in
            Button { config.showSettingsView() } label: { Image(systemName: "gearshape") }
        }
*/
        // let xx = x(config)
/*
        return [
            // xx,
            ImageContentView.ToolBarViewBuilder { _ in
                Text("hOMe")
            }(config),
            ImageContentView.ToolBarViewBuilder { config in
                Button { config.showSettingsView() } label: { Image(systemName: "gearshape") }
            }(config)
        ]
*/
        return [
            ImageContentView.ToolBarViewBuilder { _ in
                Text("hOMe")
            },
            ImageContentView.ToolBarViewBuilder { config in
                Button { config.showSettingsView() } label: { Image(systemName: "gearshape") }
            }
        ].map { item in item(config) }
    }

/*
    public static func tb(@ViewBuilder _ make: @escaping (ImageContentView.Config) -> some View) -> (ImageContentView.Config) -> AnyView {
        { cfg in AnyView(make(cfg)) }
    }
*/
}
