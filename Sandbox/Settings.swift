import SwiftUI
import CellGridView
import Utils

public class Settings: ObservableObject
{
    public init(contentView: ImageContentView.Config) {
        self.contentView = contentView
    }

    @Published public var contentView: ImageContentView.Config
    @Published public var cellSize: Int             = 42
    @Published public var cellFit: CellGridView.Fit = CellGridView.Fit.fixed
    @Published public var cellColor: Colour         = Colour.red

    public let cellSizeMax: Int          = 200
    public let cellFitMarginMax: Int     = 120
}
