import SwiftUI

public class CellGridView
{
    public class Config
    {
        public private(set) var scaling: Bool             = true
        public private(set) var cellSize: Int             = 43
        public private(set) var cellPadding: Int          = 1
        public private(set) var cellShading: Bool         = false

        public let cellSizeMax: Int          = 200
        public let cellSizeInnerMin: Int     = 1
        public let cellPaddingMax: Int       = 8
        public let cellFitMarginMax: Int     = 120

        public init(config: Config? = nil,
                    scaling: Bool? = nil,
                    cellSize: Int? = nil,
                    cellPadding: Int? = nil,
                    cellShading: Bool? = nil
        )
        {
            self.scaling = scaling ?? config?.scaling ?? Config.Defaults.scaling
            self.cellSize = cellSize ?? Config.Defaults.cellSize
            self.cellPadding = cellPadding ?? Config.Defaults.cellPadding
            self.cellShading = cellShading ?? Config.Defaults.cellShading
        }

        public class var Defaults: Config { Config.instance }
        private static let instance: Config = Config(defaults: true)
        internal init(defaults: Bool) {}
    }
}

public class ImageView: CellGridView
{
    public class Config: CellGridView.Config
    {
        public private(set) var activeColor: Color = Color.black
        public private(set) var inactiveColor: Color = Color.white

        public init(config: Config? = nil,
                    scaling: Bool? = nil,
                    cellSize: Int? = nil,
                    cellPadding: Int? = nil,
                    cellShading: Bool? = nil,
                    activeColor: Color? = nil,
                    inactiveColor: Color? = nil
        )
        {
            self.activeColor = activeColor ?? config?.activeColor ?? Config.Defaults.activeColor
            self.inactiveColor = inactiveColor ?? config?.inactiveColor ?? Config.Defaults.inactiveColor
            super.init(config: config,
                       scaling: scaling,
                       cellSize: cellSize,
                       cellPadding: cellPadding,
                       cellShading: cellShading)
        }

        public override class var Defaults: Config { Config.instance }
        private static let instance: Config = Config(defaults: true)
        internal override init(defaults: Bool) { super.init(defaults: defaults) }
    }
}

public class Settings: ObservableObject
{
}

// let x = ImageView.Config.Defaults
// let y = ImageView.Config.Defaults
// let z = ImageView.Config.Defaults

var config: ImageView.Config = ImageView.Config(scaling: true)
print(config.scaling)
print(config.cellSize)
//ImageView.Config.Defaults.scaling = false

public class A {
    private let foo: Int = 1
}
public class B: A {
    public let foo: Int = 2
}

print("FOO")
var x = CellGridView.Config.Defaults
x = CellGridView.Config.Defaults
x = CellGridView.Config.Defaults
x = CellGridView.Config.Defaults
x = CellGridView.Config.Defaults
print(x.cellSize)
