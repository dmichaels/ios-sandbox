import SwiftUI
import CellGridView
import Utils

public class Settings: ObservableObject
{
    public var contentView: ImageContentView.Config = ImageContentView.Config(
        hideStatusBar:  false,
        hideToolBar:    false,
        ignoreSafeArea: false,
        background:     ImageView.Config.Defaults.viewBackground
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

    /*
    public func fromConfig(config: ImageView.Config) {
        self.scaling        = config.scaling
        self.cellSize       = config.cellSize
        self.cellPadding    = config.cellPadding
        self.cellFit        = config.cellFit
        self.cellColor      = config.cellColor
        self.cellShape      = config.cellShape
        self.cellShading    = config.cellShading
        self.viewBackground = config.viewBackground
    }

    public func toConfig() -> ImageView.Config {
        return ImageView.Config(
            scaling: self.scaling
        )
    }
    */

    public static let Defaults: Settings = Settings()
}
