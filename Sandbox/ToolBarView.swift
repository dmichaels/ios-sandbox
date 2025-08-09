import SwiftUI

public func ToolBarView(_ config: ImageContentView.Config) -> [AnyView] {
    return ImageContentView.ToolBarView(config, 
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
    )
}
