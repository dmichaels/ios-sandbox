import SwiftUI
import CellGridView
import Utils

public class LifeCellGridImageView: CellGridImageView, ImageContentView.ImageViewable
{
    private var _settings: Settings
    private var _activeCellColor: Colour = Config.Defaults.activeCellColor
    private var _inactiveCellColor: Colour = Config.Defaults.inactiveCellColor
    private var _activeCells: Set<ViewLocation> = []

    public override init(settings: Settings) {
        _settings = settings
        super.init(settings: settings)
    }

    public override func cellColor(_ location: ViewLocation, primary: Bool = false) -> Colour {
        // return _activeCells.contains(location) ? (primary ? Colour.red : Colour.red.lighten(by: 0.5))
        //                                        : super.cellColor(location, primary: primary)
        return _activeCells.contains(location) ? (primary ? self._activeCellColor : self._inactiveCellColor)
                                               : super.cellColor(location, primary: primary)
    }

    public func setupSettings() {
        //
        // Called by virtue of calling: _settings.contentView.showSettingsView()
        //
        _settings.scaling     = super.scaling
        _settings.cellFit     = super.cellFit
        _settings.cellColor   = super.cellColor
        _settings.cellShape   = super.cellShape
        _settings.cellShading = super.cellShading
        _settings.cellSize    = super.cellSize // Use unscaled in SettingsView
    }

    public func applySettings() {
        //
        // Called by virtue of calling: _settings.contentView.applySettings()
        //
        let config: CellGridImageView.Config = _settings.toConfig()
        /*
        _setViewSize(CGSize(width: _viewWidth, height: _viewHeight), scaled: _scaling, scaling: _settings.scaling)
        _scaling   = _settings.scaling
        _cellFit   = _settings.cellFit
        _cellColor = _settings.cellColor
        _setCellSize(_settings.cellSize, scaled: false) // Use unscaled in SettingsView
        _update()
        */
    }

    public override func updateImage(notify: Bool = true) {
        super.updateImage(notify: notify)
        if (notify) {
            _settings.contentView.updateImage()
        }
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
        super.updateImage()
    }

    public func onSwipeLeft() {
        _settings.contentView.showSettingsView()
    }
}
