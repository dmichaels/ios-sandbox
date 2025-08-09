import SwiftUI

public func ToolBarViews(_ config: ImageContentView.Config) -> ImageContentView.ToolBarViewables {
    return ImageContentView.ToolBarViewable(config, 
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
