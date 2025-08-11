import SwiftUI
import Utils

public class Settings: ObservableObject, @unchecked Sendable
{
    public init(contentView: ImageContentView.Config) {
        self.contentView = contentView
    }

    public var contentView: ImageContentView.Config
    public var squareColor: Colour = Colour.magenta
    public var large: Bool = false
}
