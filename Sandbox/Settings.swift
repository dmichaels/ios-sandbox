import SwiftUI
import Utils

public class Settings: ObservableObject
{
    public init(_ contentView: ImageContentView.Config) {
        self.config = contentView
        self.contentView = contentView
    }

    @Published public var config: ImageContentView.Config
    @Published public var contentView: ImageContentView.Config
    @Published public var squareColor: Colour = Colour.magenta
    @Published public var large: Bool = false

    // public static let Defaults: Settings = Settings()
}
