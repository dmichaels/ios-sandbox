import SwiftUI
import CellGridView
import Utils

public class Settings: ObservableObject
{
    public var contentView: ImageContentView.Config = ImageContentView.Config(
        hideStatusBar:  false,
        hideToolBar:    false,
        ignoreSafeArea: true,
        background:     Colour.cyan
    )

    public var imageView: LifeCellGridImageView {
        //
        // Hookup of imageView to ImageContentView.Config is done in ImageContentView constructor.
        // Used in SettingsView.
        //
        self.contentView.imageView as! LifeCellGridImageView
    }

    @Published public var scaling: Bool             = true
    @Published public var cellSize: Int             = 23
    @Published public var cellPadding: Int          = 1
    @Published public var cellFit: CellGridView.Fit = CellGridView.Fit.fixed
    @Published public var cellColor: Colour         = Colour.blue
    @Published public var cellShape: CellShape      = CellShape.rounded
    @Published public var cellShading: Bool         = true

    @Published public var activeCellColor: Colour   = Colour.red
    @Published public var inactiveCellColor: Colour = Colour.green
    @Published public var viewBackground: Colour    = Colour.yellow

    public func fromConfig(config: LifeCellGridImageView.Config)
    {
        self.scaling           = config.scaling
        self.cellSize          = config.cellSize
        self.cellPadding       = config.cellPadding
        self.cellFit           = config.cellFit
        self.cellColor         = config.cellColor
        self.cellShape         = config.cellShape
        self.cellShading       = config.cellShading
        self.activeCellColor   = config.activeCellColor
        self.inactiveCellColor = config.activeCellColor
        self.viewBackground    = config.viewBackground
    }

    public func fromConfig(config: LifeCellGridImageView.Config? = nil,
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
            let d: Settings                      = Settings.Defaults

            self.scaling           = scaling           ?? c?.scaling           ?? d.scaling
            self.cellSize          = cellSize          ?? c?.cellSize          ?? d.cellSize
            self.cellPadding       = cellPadding       ?? c?.cellPadding       ?? d.cellPadding
            self.cellFit           = cellFit           ?? c?.cellFit           ?? d.cellFit
            self.cellShape         = cellShape         ?? c?.cellShape         ?? d.cellShape
            self.cellShading       = cellShading       ?? c?.cellShading       ?? d.cellShading
            self.activeCellColor   = activeCellColor   ?? c?.activeCellColor   ?? d.activeCellColor
            self.inactiveCellColor = inactiveCellColor ?? c?.inactiveCellColor ?? d.inactiveCellColor
    }

    public func toConfig() -> LifeCellGridImageView.Config
    {
        return LifeCellGridImageView.Config(scaling:           self.scaling,
                                            cellSize:          self.cellSize,
                                            cellPadding:       self.cellPadding,
                                            cellFit:           self.cellFit,
                                            cellColor:         self.cellColor,
                                            cellShape:         self.cellShape,
                                            cellShading:       self.cellShading,
                                            activeCellColor:   self.activeCellColor,
                                            inactiveCellColor: self.inactiveCellColor,
                                            viewBackground:    self.viewBackground)
    }

    public var config: LifeCellGridImageView.Config { self.toConfig() }

    public static let Defaults: Settings = Settings()
}
