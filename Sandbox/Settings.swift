import SwiftUI
import Utils

public class Settings: ObservableObject
{
    public init(contentView: ImageContentView.Config) {
        self.contentView = contentView
    }

    public var contentView: ImageContentView.Config
    public var squareColor: Colour = Colour.red
    public var squareSizeSmall: Bool = true
    public var innerSquareColor: Colour = Colour.magenta
}
