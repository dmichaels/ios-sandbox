import Utils

extension LifeCellGridImageView
{
    public class Config // : CellGridImageView.Config
    {
        public var activeCellColor: Colour   = Colour.red
        public var inactiveCellColor: Colour = Colour.gray
        public var viewBackground: Colour    = Colour.white

        public init(config: Config? = nil,
                    activeCellColor: Colour? = nil,
                    inactiveCellColor: Colour? = nil,
                    viewBackground: Colour? = nil)
        {
            self.activeCellColor = activeCellColor ?? Config.Defaults.activeCellColor
            self.viewBackground  = viewBackground  ?? Config.Defaults.viewBackground
        }

        public init(defaults _: Bool) {}
        public static let Defaults: Config = Config(defaults: true)
    }
}
