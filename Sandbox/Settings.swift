import SwiftUI
import CellGridView
import Utils

public class Settings: ObservableObject
{
    public var contentView: ImageContentView.Config = ImageContentView.Config(
        hideStatusBar:  false,
        hideToolBar:    false,
        ignoreSafeArea: false,
        background:     LifeCellGridImageView.Config.Defaults.viewBackground
    )

    public var imageView: LifeCellGridImageView {
        //
        // Hookup of imageView to ImageContentView.Config is done in ImageContentView constructor.
        //
        self.contentView.imageView as! LifeCellGridImageView
    }

    @Published public var scaling: Bool             = true
    @Published public var cellSize: Int             = 43
    @Published public var cellPadding: Int          = 1
    @Published public var cellFit: CellGridView.Fit = CellGridView.Fit.fixed
    @Published public var cellColor: Colour         = Colour.blue
    @Published public var cellShape: CellShape      = CellShape.rounded
    @Published public var cellShading: Bool         = true
    @Published public var viewBackground: Colour    = Colour.white

    public func fromConfig(config: CellGridImageView.Config) {
        self.scaling        = config.scaling
        self.cellSize       = config.cellSize
        self.cellPadding    = config.cellPadding
        self.cellFit        = config.cellFit
        self.cellColor      = config.cellColor
        self.cellShape      = config.cellShape
        self.cellShading    = config.cellShading
        self.viewBackground = config.viewBackground
    }

    public func toConfig() -> CellGridImageView.Config {
        return CellGridImageView.Config(
            scaling:        self.scaling,
            cellSize:       self.cellSize,
            cellPadding:    self.cellPadding,
            cellFit:        self.cellFit,
            cellColor:      self.cellColor,
            cellShape:      self.cellShape,
            cellShading:    self.cellShading,
            viewBackground: self.viewBackground
        )
    }

    public static let Defaults: Settings = Settings()
   }
