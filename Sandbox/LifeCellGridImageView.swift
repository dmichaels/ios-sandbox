import SwiftUI
import CellGridView
import Utils

public class LifeCellGridImageView: CellGridImageView, ImageContentView.ImageViewable
{
    private var _settings: Settings
    private var _activeCellColor: Colour = Config.Defaults.activeCellColor
    private var _inactiveCellColor: Colour = Config.Defaults.inactiveCellColor
    private var _activeCells: Set<ViewLocation> = []

    public init(settings: Settings) {
        _settings = settings
        super.init(settings.config)
    }

    internal func setupConfig(_ config: Config) {
        config.activeCellColor = _activeCellColor
        config.inactiveCellColor = _inactiveCellColor
    }

    public func setupSettings() {
        //
        // Setup our Settings object (_settings) from our data.
        //
        // Called by virtue of calling: _settings.contentView.showSettingsView()
        //
        let config: Config = Config(self)
        _settings.scaling           = config.scaling
        _settings.cellSize          = config.cellSize // Note unscaled for SettingsView
        _settings.cellPadding       = config.cellPadding
        _settings.cellFit           = config.cellFit
        _settings.cellColor         = config.cellColor
        _settings.cellShape         = config.cellShape
        _settings.cellShading       = config.cellShading
        _settings.activeCellColor   = config.activeCellColor
        _settings.inactiveCellColor = config.inactiveCellColor
        /*
        _settings.scaling           = super.scaling
        _settings.cellSize          = super.cellSize // Note unscaled for SettingsView
        _settings.cellPadding       = super.cellPadding
        _settings.cellFit           = super.cellFit
        _settings.cellColor         = super.cellColor
        _settings.cellShape         = super.cellShape
        _settings.cellShading       = super.cellShading
        _settings.activeCellColor   = _activeCellColor
        _settings.inactiveCellColor = _inactiveCellColor
        */
    }

    public func applySettings() {
        //
        // Called by virtue of calling: _settings.contentView.applySettings()
        //
        let config: Config = _settings.toConfig()
        _activeCellColor = config.activeCellColor
        _inactiveCellColor = config.inactiveCellColor
        super.update(config)
    }

    public override func updateImage(notify: Bool = true) {
        super.updateImage(notify: notify)
        if (notify) {
            _settings.contentView.updateImage()
        }
    }

    public override func cellColor(_ location: ViewLocation, primary: Bool = false) -> Colour {
        return _activeCells.contains(location) ? (primary ? self._activeCellColor : self._inactiveCellColor)
                                               : super.cellColor(location, primary: primary)
    }

    public func onTap(_ point: CGPoint) {
        let point: ViewPoint = ViewPoint(point)
        let cellLocation: CellLocation = CellLocation(point.x / super.cellSize, point.y / self.cellSize)
        if (_activeCells.contains(cellLocation)) {
            _activeCells.remove(cellLocation)
        }
        else {
            _activeCells.insert(cellLocation)
        }
        self.updateImage()
    }

    public func onSwipeLeft() {
        _settings.contentView.showSettingsView()
    }
}
