import SwiftUI
import CellGridView
import Utils

extension CellGridImageView
{
    public class Config // : ImageContentView.Config, @unchecked Sendable
    {
        public var scaling: Bool             = true
        public var cellSize: Int             = 43
        public var cellPadding: Int          = 1
        public var cellFit: CellGridView.Fit = CellGridView.Fit.fixed
        public var cellColor: Colour         = Colour.red
        public var cellShape: CellShape      = CellShape.rounded
        public var cellShading: Bool         = false
        public var viewBackground: Colour    = Colour.white

        public let cellSizeMax: Int          = 200
        public let cellSizeInnerMin: Int     = 1
        public let cellPaddingMax: Int       = 8
        public let cellFitMarginMax: Int     = 120

        /*
        public init(config: Config? = nil,
                    scaling: Bool? = nil,
                    cellSize: Int? = nil,
                    cellPadding: Int? = nil,
                    cellFit: CellGridView.Fit? = nil,
                    cellColor: Colour? = nil,
                    cellShape: CellShape? = nil,
                    cellShading: Bool? = nil,
                    viewBackground: Colour? = nil)
        {
            self.scaling = scaling ?? config?.scaling ?? Config.Defaults.scaling
            self.cellSize = cellSize ?? Config.Defaults.cellSize
            self.cellPadding = cellPadding ?? Config.Defaults.cellPadding
            self.cellShading = cellShading ?? Config.Defaults.cellShading
        }
        */

        public class var Defaults: Config { Config.instance }
        private static let instance: Config = Config(defaults: true)
        public init(defaults _: Bool) { }

        // public static let Defaults: Config = Config()
    }
}
