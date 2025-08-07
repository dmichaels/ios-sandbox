import SwiftUI

public struct YToolBarView<Content: ToolbarContent>: ToolbarContent {
    private let config: ImageContentView.Config
    private let content: Content
    public init( _ config: ImageContentView.Config, @ToolbarContentBuilder content: () -> Content) {
        self.config = config
        self.content = content()
    }
    public var body: some ToolbarContent {
        content
    }
}
