import CellGridView
import Utils

extension LifeCellGridImageView
{
    public class Config: CellGridImageView.Config
    {
        public var activeCellColor: Colour   = Colour.red
        public var inactiveCellColor: Colour = Colour.gray
        public var viewBackground: Colour    = Colour.white

        public init(config: Config? = nil,
                    scaling: Bool? = nil,
                    cellSize: Int? = nil,
                    cellPadding: Int? = nil,
                    cellFit: CellGridView.Fit? = nil,
                    cellColor: Colour? = nil,
                    cellShape: CellShape? = nil,
                    cellShading: Bool? = nil,
                    activeCellColor: Colour? = nil,
                    inactiveCellColor: Colour? = nil,
                    viewBackground: Colour? = nil)
        {
            let c: LifeCellGridImageView.Config? = config
            let d: LifeCellGridImageView.Config = Config.Defaults

            self.activeCellColor   = activeCellColor   ?? c?.activeCellColor   ?? d.activeCellColor
            self.inactiveCellColor = inactiveCellColor ?? c?.inactiveCellColor ?? d.inactiveCellColor
            self.viewBackground    = viewBackground    ?? c?.viewBackground    ?? d.viewBackground

            super.init(scaling:     scaling,
                       cellSize:    cellSize,
                       cellPadding: cellPadding,
                       cellFit:     cellFit,
                       cellColor:   cellColor,
                       cellShape:   cellShape,
                       cellShading: cellShading)
        }

        public required init(defaults: Bool) { super.init(defaults: true) }
    }
}
