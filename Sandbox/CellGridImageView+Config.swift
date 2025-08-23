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

        public init(_ cellGridImageView: CellGridImageView) {
            cellGridImageView.setupConfig(self)
        }

        public init(_ config: Config? = nil,
                      scaling: Bool? = nil,
                      cellSize: Int? = nil,
                      cellSizeMax: Int? = nil,
                      cellSizeInnerMin: Int? = nil,
                      cellPadding: Int? = nil,
                      cellPaddingMax: Int? = nil,
                      cellFit: CellGridView.Fit? = nil,
                      cellFitMarginMax: Int? = nil,
                      cellColor: Colour? = nil,
                      cellShape: CellShape? = nil,
                      cellShading: Bool? = nil)
        {
            let c: Config? = config
            let d: Config  = Config.Defaults

            self.scaling          = scaling          ?? c?.scaling          ?? d.scaling
            self.cellSize         = cellSize         ?? c?.cellSize         ?? d.cellSize
            self.cellSizeMax      = cellSizeMax      ?? c?.cellSizeMax      ?? d.cellSizeMax
            self.cellSizeInnerMin = cellSizeInnerMin ?? c?.cellSizeInnerMin ?? d.cellSizeInnerMin
            self.cellPadding      = cellPadding      ?? c?.cellPadding      ?? d.cellPadding
            self.cellPaddingMax   = cellPaddingMax   ?? c?.cellPaddingMax   ?? d.cellPaddingMax
            self.cellFit          = cellFit          ?? c?.cellFit          ?? d.cellFit
            self.cellFitMarginMax = cellFitMarginMax ?? c?.cellFitMarginMax ?? d.cellFitMarginMax
            self.cellColor        = cellColor        ?? c?.cellColor        ?? d.cellColor
            self.cellShape        = cellShape        ?? c?.cellShape        ?? d.cellShape
            self.cellShading      = cellShading      ?? c?.cellShading      ?? d.cellShading
        }

        public required init(defaults _: Bool) {}
        public class var Defaults: Self { Self.init(defaults: true) }
    }
}
