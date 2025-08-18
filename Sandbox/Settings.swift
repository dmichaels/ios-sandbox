import SwiftUI
import CellGridView
import Utils

public class Settings: ObservableObject
{
    public init(contentView: ImageContentView.Config) {
        self.contentView = contentView
    }

    @Published public var contentView: ImageContentView.Config
    @Published public var cellFit: CellGridView.Fit = CellGridView.Fit.fixed
    @Published public var cellColor: Colour         = Colour.red
    @Published public var cellSize: Int             = 43
    @Published public var scaling: Bool             = true

    public let cellSizeMax: Int      = 300
    public let cellFitMarginMax: Int = 120
    public let displayScale: CGFloat = UIScreen.main.scale

    public static let Defaults: Settings = Settings(contentView: ImageContentView.Config.Defaults)
}
