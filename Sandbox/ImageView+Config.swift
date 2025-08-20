import SwiftUI
import CellGridView
import Utils

extension ImageView
{
    public struct Config
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

        public static let Defaults: Config = Config()
    }
}
