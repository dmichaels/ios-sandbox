import SwiftUI
import Utils

public func ToolBarViews(settings: Settings) -> ImageContentView.ToolBarViewables {
    return ImageContentView.ToolBarViewable(settings.contentView, 
        ImageContentView.ToolBarItem { _ in
            Text("Home")
        },
        ImageContentView.ToolBarItem { contentView in
            Button {
                contentView.showSettingsView()
            }
            label: {
                Image(systemName: "gearshape")
            }
        }
    )
}
