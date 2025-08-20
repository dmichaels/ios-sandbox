import SwiftUI
import CellGridView
import Utils

public class Settings: ObservableObject
{
    public var contentView: ImageContentView.Config = ImageContentView.Config(
        hideStatusBar:  false,
        hideToolBar:    false,
        ignoreSafeArea: false,
        background:     Config.Defaults.viewBackground
    )

    public var imageView: ImageView {
        //
        // Hookup of imageView to ImageContentView.Config is done in ImageContentView constructor.
        //
        self.contentView.imageView as! ImageView
    }

    @Published public var scaling: Bool             = true
    @Published public var cellSize: Int             = 43
    @Published public var cellPadding: Int          = 1
    @Published public var cellFit: CellGridView.Fit = CellGridView.Fit.fixed
    @Published public var cellColor: Colour         = Colour.red
    @Published public var cellShape: CellShape      = CellShape.rounded
    @Published public var cellShading: Bool         = true
    @Published public var viewBackground: Colour    = Colour.white

    public let cellSizeMax: Int      = Int(CGFloat(200) * Config.Defaults.screenScale)
    public let cellSizeInnerMin: Int = 1
    public let cellPaddingMax: Int   = 8
    public let cellFitMarginMax: Int = 120
    public let screenScale: CGFloat = UIScreen.main.scale

    public static let Defaults: Settings = Settings()
}

public class Config
{
    public let scaling: Bool             = true
    public let cellSize: Int             = 43
    public let cellPadding: Int          = 1
    public let cellFit: CellGridView.Fit = CellGridView.Fit.fixed
    public let cellColor: Colour         = Colour.red
    public let cellShape: CellShape      = CellShape.rounded
    public let viewBackground: Colour    = Colour.white

    public let cellSizeMax: Int      = 200
    public let cellSizeInnerMin: Int = 1
    public let cellPaddingMax: Int   = 8
    public let cellFitMarginMax: Int = 120
    public let screenScale: CGFloat = UIScreen.main.scale

    public static let Defaults: Config = Config()
}
