import SwiftUI
import CellGridView
import Utils

public class LifeCellGridImageView: CellGridImageView, ImageContentView.ImageViewable
{
    private var _settings: Settings
    private var _activeCells: Set<ViewLocation> = []

    public override init(settings: Settings) {
        _settings = settings
        super.init(settings: settings)
    }

    public override func cellColor(_ location: ViewLocation, primary: Bool = false) -> Colour {
        return _activeCells.contains(location) ? (primary ? Colour.red : Colour.red.lighten(by: 0.5))
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
        super._updateImage()
    }
}
