import SwiftUI
import CellGridView
import Utils

extension CellGridImageView
{
    public class Config
    {
        public var scaling: Bool             = true
        public var cellSize: Int             = 43
        public var cellPadding: Int          = 1
        public var cellFit: CellGridView.Fit = CellGridView.Fit.fixed
        public var cellColor: Colour         = Colour.blue
        public var cellShape: CellShape      = CellShape.rounded
        public var cellShading: Bool         = false

        public let cellSizeMax: Int          = 200
        public let cellSizeInnerMin: Int     = 1
        public let cellPaddingMax: Int       = 8
        public let cellFitMarginMax: Int     = 120

        public init(config: Config? = nil,
                    scaling: Bool? = nil,
                    cellSize: Int? = nil,
                    cellPadding: Int? = nil,
                    cellFit: CellGridView.Fit? = nil,
                    cellColor: Colour? = nil,
                    cellShape: CellShape? = nil,
                    cellShading: Bool? = nil)
        {
            self.scaling     = scaling     ?? config?.scaling ?? Config.Defaults.scaling
            self.cellSize    = cellSize    ?? Config.Defaults.cellSize
            self.cellPadding = cellPadding ?? Config.Defaults.cellPadding
            self.cellFit     = cellFit     ?? Config.Defaults.cellFit
            self.cellColor   = cellColor   ?? Config.Defaults.cellColor
            self.cellShape   = cellShape   ?? Config.Defaults.cellShape
            self.cellShading = cellShading ?? Config.Defaults.cellShading
        }

        public required init(defaults _: Bool) {}
        public class var Defaults: Self { Self.init(defaults: true) }
    }
}
