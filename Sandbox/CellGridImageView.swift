import SwiftUI
import CellGridView
import Utils

public class CellGridImageView
{
    private var _settings: Settings
    private var _image: CGImage = DefaultImage.instance
    //
    // We store the SCALED values INTERNALLY with the normal variable names and the UNSCALED values with variable
    // names suffixed with "US"; but EXTERNALLY (outward-facing) it's the OPPOSITE, with the normal variable names
    // representing the UNSCALED values and the SCALED values with special variable names suffixed with "Scaled".
    // And note that when UNSCALED the scaled and unscaled variable values are the SAME, i.e. BOTH UNSCALED.
    //
    private var _scaling:       Bool = Settings.Defaults.scaling

    private var _viewSize:      CGSize = CGSize.zero // Temporary
    private var _viewWidth:     Int  = 0
    private var _viewWidthUS:   Int  = 0
    private var _viewHeight:    Int  = 0
    private var _viewHeightUS:  Int  = 0

    private var _imageWidth:    Int  = 0
    private var _imageWidthUS:  Int  = 0
    private var _imageHeight:   Int  = 0
    private var _imageHeightUS: Int  = 0

    private var _cellSize: Int        = Scale(Config.Defaults.cellSize, Config.Defaults.scaling)
    private var _cellSizeUS: Int      = Config.Defaults.cellSize
    private var _cellPadding: Int     = Scale(Config.Defaults.cellPadding, Config.Defaults.scaling)
    private var _cellPaddingUS: Int   = Config.Defaults.cellPadding

    private var _cellFit: CellGridView.Fit = Config.Defaults.cellFit
    private var _cellColor: Colour         = Config.Defaults.cellColor
    private var _cellShape: CellShape      = CellShape.rounded
    private var _cellShading: Bool         = Config.Defaults.cellShading

    private var _cellSizeMax: Int = Scale(Config.Defaults.cellSizeMax, Config.Defaults.scaling)
    private var _cellSizeMaxUS: Int = Config.Defaults.cellSizeMax
    private var _cellPaddingMax: Int = Scale(Config.Defaults.cellPaddingMax, Config.Defaults.scaling)
    private var _cellPaddingMaxUS: Int = Config.Defaults.cellPaddingMax
    private var _cellSizeInnerMin:  Int = Scale(Config.Defaults.cellSizeInnerMin, Config.Defaults.scaling)
    private var _cellSizeInnerMinUS: Int = Config.Defaults.cellSizeInnerMin
    private var _cellFitMarginMax: Int = Scale(Config.Defaults.cellFitMarginMax, Config.Defaults.scaling)
    private var _cellFitMarginMaxUS: Int = Config.Defaults.cellFitMarginMax

    // internal var _buffer: [UInt8] = []
    // internal var _bufferBlocks: CellGridView.BufferBlocks = CellGridView.BufferBlocks()

    private var _zoomCellSize:  Int? = nil

    // internal var _activeCells: Set<ViewLocation> = []

    public var imageWidth: Int             { _imageWidthUS }
    public var imageWidthScaled: Int       { _imageWidth }
    public var imageHeight: Int            { _imageHeightUS }
    public var imageHeightScaled: Int      { _imageHeight }
    public var cellSize: Int               { _cellSizeUS }
    public var cellSizeScaled: Int         { _cellSize }
    public var cellSizeMax: Int            { _cellSizeMaxUS }
    public var cellSizeMaxScaled: Int      { _cellSizeMax }
    public var cellSizeInnerMin: Int       { _cellSizeInnerMinUS }
    public var cellSizeInnerMinScaled: Int { _cellSizeInnerMin }
    public var cellPaddingMax: Int         { _cellPaddingMaxUS }
    public var cellPaddingMaxScaled: Int   { _cellPaddingMax }

    public init(settings: Settings) {
        _settings = settings
        print("INIT> ds: \(Display.size) ds: \(Display.scale) dw: \(Display.width) hw: \(Display.height)")
    }

    public var image: CGImage { _image }
    public var size:  CGSize  { CGSize(width: _imageWidthUS, height: _imageHeightUS) }
    public var scale: CGFloat { _scaling ? Display.scale : 1.0 }

    public func update(viewSize: CGSize) {

        guard viewSize.width > 0, viewSize.height > 0 else { return }

        _viewSize = viewSize
        _setViewSize(viewSize, scaled: false) // Assume viewSize (from ContentView) is always unscaled

/*
        let bufferSize: Int = _viewWidth * _viewHeight * Display.channels
        if (bufferSize != _buffer.count) {
            _buffer = Memory.allocate(_viewWidth * _viewHeight * Display.channels)
        }
        _bufferBlocks = CellGridView.BufferBlocks.createBufferBlocks(
            bufferSize: _buffer.count,
            viewWidth: _viewWidth,
            viewHeight: _viewHeight,
            cellSize: _cellSize,
            cellPadding: _cellPadding,
            cellShape: _cellShape,
            cellShading: _cellShading)
*/

        _update(notify: false)
    }

    private func _update(cellSize: Int) {
        guard cellSize > 0 else { return }
        _setCellSize(cellSize, scaled: _scaling)
        _update()
    }

    private func _update(notify: Bool = true) {
        let preferred: CellGridView.PreferredSize = CellGridView.preferredSize(
            cellSize: _cellSize, viewWidth: _viewWidth, viewHeight: _viewHeight,
            fit: _cellFit, fitMarginMax: _cellFitMarginMax)
        _setImageSize(preferred.viewWidth, preferred.viewHeight, scaled: _scaling)
        _setCellSize(preferred.cellSize, scaled: _scaling)
        _updateImage(notify: notify)
    }

    internal func _updateImage(notify: Bool = true) {
        _image = _createImage(imageWidth: _imageWidth, imageHeight: _imageHeight)
        if (notify) { _settings.contentView.updateImage() }
    }

    public func setupSettings() {
        //
        // Called by virtue of calling: _settings.contentView.showSettingsView()
        //
        _settings.scaling   = _scaling
        _settings.cellFit   = _cellFit
        _settings.cellColor = _cellColor
        _settings.cellSize  = _cellSizeUS // Use unscaled in SettingsView
    }

    public func applySettings() {
        //
        // Called by virtue of calling: _settings.contentView.applySettings()
        //
        _setViewSize(CGSize(width: _viewWidth, height: _viewHeight), scaled: _scaling, scaling: _settings.scaling)
        _scaling   = _settings.scaling
        _cellFit   = _settings.cellFit
        _cellColor = _settings.cellColor
        _setCellSize(_settings.cellSize, scaled: false) // Use unscaled in SettingsView
        _update()
    }

    /*
    public func config: CellGridImageView.Config {
        return CellGridImageView.Config(scaling: _scaling,
                                cellSize: _cellSize,
                                cellPadding: _cellSize,
                                cellFit: _cellSize,
                                cellColor: _cellSize,
                                cellShape: _cellSize,
                                cellShading: _cellSize,
                                viewBackground: _cellSize,)
    }
    */

    public func onZoom(_ zoomFactor: CGFloat) {
        if (_zoomCellSize == nil) { _zoomCellSize = _cellSize }
        _update(cellSize: Int(CGFloat(_zoomCellSize!) * zoomFactor).clamped(1..._cellSizeMax))
    }

    public func onZoomEnd(_ zoomFactor: CGFloat) {
        self.onZoom(zoomFactor) ; _zoomCellSize = nil
    }

    public func onSwipeLeft() {
        _settings.contentView.showSettingsView()
    }

    private func x_createImage(imageWidth: Int? = nil, imageHeight: Int? = nil, cellSize: Int? = nil) -> CGImage {
        let imageWidth:  Int = (imageWidth  ?? _imageWidth)
        let imageHeight: Int = (imageHeight ?? _imageHeight)
        let cellSize:    Int = (cellSize    ?? _cellSize)
        guard imageWidth > 0, imageHeight > 0 else { return DefaultImage.instance }
        let context: CGContext = DefaultImage.context(width: imageWidth, height: imageHeight)
        context.setFillColor(Colour.white.cgcolor)
        context.fill(CGRect(x: 0, y: 0, width: imageWidth, height: imageHeight))
        for y in stride(from: 0, to: imageHeight, by: cellSize) {
            for x in stride(from: 0, to: imageWidth, by: cellSize) {
                context.setFillColor((((x + y) / cellSize) % 2 == 0) ? _cellColor.cgcolor : Colour.white.cgcolor)
                let cw: Int = min(cellSize, imageHeight - y > 0 ? cellSize : 0 + (imageWidth - x))
                let ch: Int = min(cellSize, imageHeight - y)
                context.fill(CGRect(x: x, y: y, width: cw, height: ch))
            }
        }
        return context.makeImage()!
    }

    private func _createImage(imageWidth: Int? = nil,
                              imageHeight: Int? = nil,
                              cellSize: Int? = nil,
                              cornerFraction: CGFloat = 0.25) -> CGImage
    {
        let imageWidth:  Int = imageWidth  ?? _imageWidth
        let imageHeight: Int = imageHeight ?? _imageHeight
        let cellSize:    Int = cellSize    ?? _cellSize
        guard imageWidth > 0, imageHeight > 0, cellSize > 0 else { return DefaultImage.instance }
        let context: CGContext = DefaultImage.context(width: imageWidth, height: imageHeight)
        context.translateBy(x: 0, y: CGFloat(imageHeight))
        context.scaleBy(x: 1, y: -1)
        context.setFillColor(Colour.white.cgcolor)
        context.fill(CGRect(x: 0, y: 0, width: imageWidth, height: imageHeight))
        context.setAllowsAntialiasing(true)
        context.setShouldAntialias(true)
        for y in stride(from: 0, to: imageHeight, by: cellSize) {
            let yy: Int = min(y + cellSize, imageHeight)
            let ch: Int = yy - y
            for x in stride(from: 0, to: imageWidth, by: cellSize) {
                let xx: Int = min(x + cellSize, imageWidth)
                let cw: Int = xx - x
                let inset: CGFloat = 1
                let rectangle: CGRect = CGRect(x: x, y: y, width: cw, height: ch).insetBy(dx: inset, dy: inset)
                let radius: CGFloat = max(0, min(rectangle.width, rectangle.height)) * cornerFraction
                let primary: Bool = ((x + y) / cellSize) % 2 == 0
                context.setFillColor(self.cellColor(ViewPoint(x / _cellSize, y / _cellSize), primary: primary).cgcolor)
                context.addPath(CGPath(roundedRect: rectangle, cornerWidth: radius, cornerHeight: radius, transform: nil))
                context.fillPath()
            }
        }
        print("IM> i: \(imageWidth)x\(imageHeight) iu: \(_imageWidthUS)x\(_imageHeightUS)" +
              " vs: \(_viewSize.width)x\(_viewSize.height) v: \(_viewWidth)x\(_viewHeight)" +
              " vu: \(_viewWidthUS)x\(_viewHeightUS) c: \(_cellSize) cu: \(_cellSizeUS) s: \(_scaling)")
        return context.makeImage()!
    }

    open func cellColor(_ location: ViewLocation, primary: Bool = false) -> Colour {
        return primary ? _cellColor : Colour.white
    }

    private func _setViewSize(_ viewSize: CGSize, scaled: Bool = false, scaling: Bool? = nil) {
        guard viewSize.width > 0, viewSize.height > 0 else { return }
        let scaling: Bool = scaling ?? _scaling
        Display.scaler(Int(floor(viewSize.width)), &_viewWidth, &_viewWidthUS, scaled: scaled, scaling: scaling)
        Display.scaler(Int(floor(viewSize.height)), &_viewHeight, &_viewHeightUS, scaled: scaled, scaling: scaling)
    }

    private func _setImageSize(_ imageWidth: Int, _ imageHeight: Int, scaled: Bool = false) {
        guard imageWidth > 0, imageHeight > 0 else { return }
        Display.scaler(imageWidth, &_imageWidth, &_imageWidthUS, scaled: scaled, scaling: _scaling)
        Display.scaler(imageHeight, &_imageHeight, &_imageHeightUS, scaled: scaled, scaling: _scaling)
    }

    private func _setCellSize(_ cellSize: Int, scaled: Bool = false) {
        Display.scaler(cellSize, &_cellSize, &_cellSizeUS, scaled: scaled, scaling: _scaling)
    }
}
