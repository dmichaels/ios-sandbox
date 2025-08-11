import SwiftUI
import Utils

public func ToolBarViews(settings: Settings) -> ImageContentView.ToolBarViewables {
    return ImageContentView.ToolBarViewable(settings.config, 
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
