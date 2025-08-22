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

        public var cellSizeMax: Int          = 200
        public var cellSizeInnerMin: Int     = 1
        public var cellPaddingMax: Int       = 8
        public var cellFitMarginMax: Int     = 120

        public init(config: Config? = nil,
                    scaling: Bool? = nil,
                    cellSize: Int? = nil,
                    cellPadding: Int? = nil,
                    cellFit: CellGridView.Fit? = nil,
                    cellColor: Colour? = nil,
                    cellShape: CellShape? = nil,
                    cellShading: Bool? = nil)
        {
            let c: Config? = config
            let d: Config  = Config.Defaults

            self.scaling     = scaling     ?? c?.scaling     ?? d.scaling
            self.cellSize    = cellSize    ?? c?.cellSize    ?? d.cellSize
            self.cellPadding = cellPadding ?? c?.cellPadding ?? d.cellPadding
            self.cellFit     = cellFit     ?? c?.cellFit     ?? d.cellFit
            self.cellColor   = cellColor   ?? c?.cellColor   ?? d.cellColor
            self.cellShape   = cellShape   ?? c?.cellShape   ?? d.cellShape
            self.cellShading = cellShading ?? c?.cellShading ?? d.cellShading
        }

        public required init(defaults _: Bool) {}
        public class var Defaults: Self { Self.init(defaults: true) }
    }
}
