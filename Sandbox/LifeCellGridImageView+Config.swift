import CellGridView
import Utils

extension LifeCellGridImageView
{
    public class Config: CellGridImageView.Config
    {
        public var activeCellColor: Colour   = Settings.Defaults.activeCellColor
        public var inactiveCellColor: Colour = Settings.Defaults.inactiveCellColor
        public var viewBackground: Colour    = Colour.yellow

        // public init(config: CellGridImageView.Config? = nil) {
            // super.init(config)
        // }

        public init(_ config: Config? = nil,
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
            let c: Config? = config
            let d: Config  = Config.Defaults

            super.init(scaling:     scaling,
                       cellSize:    cellSize,
                       cellPadding: cellPadding,
                       cellFit:     cellFit,
                       cellColor:   cellColor,
                       cellShape:   cellShape,
                       cellShading: cellShading)

            self.activeCellColor   = activeCellColor   ?? c?.activeCellColor   ?? d.activeCellColor
            self.inactiveCellColor = inactiveCellColor ?? c?.inactiveCellColor ?? d.inactiveCellColor
            self.viewBackground    = viewBackground    ?? c?.viewBackground    ?? d.viewBackground
        }

        public required init(defaults: Bool) { super.init(defaults: true) } // For base-class/inherited Defaults
    }
}
