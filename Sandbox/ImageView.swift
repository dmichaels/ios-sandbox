import SwiftUI
import CellGridView
import Utils
import CoreGraphics
import UIKit   // (or AppKit on macOS)

public class ImageView: ImageContentView.Viewable
{
    private var _settings: Settings // !
    private var _image: CGImage = DefaultImage.instance
    private var _cellFit: CellGridView.Fit = Settings.Defaults.cellFit
    private var _cellColor: Colour = Settings.Defaults.cellColor
    private var _zoomStartCellSize: Int? = nil

    // We store the SCALED values INTERNALLY with the normal variable names and the UNSCALED values with variable
    // names suffixed with "US"; but EXTERNALLY (outward-facing) it's the OPPOSITE, with the normal variable names
    // representing the UNSCALED values and the SCALED values with special variable names suffixed with "Scaled".
    // And note that when UNSCALED the scaled and unscaled variable values are the SAME, i.e. BOTH UNSCALED.

    private var _scaling:       Bool = Settings.Defaults.scaling
    private var _viewWidth:     Int  = 0
    private var _viewWidthUS:   Int  = 0
    private var _viewHeight:    Int  = 0
    private var _viewHeightUS:  Int  = 0
    private var _imageWidth:    Int  = 0
    private var _imageWidthUS:  Int  = 0
    private var _imageHeight:   Int  = 0
    private var _imageHeightUS: Int  = 0
    private var _cellSize:      Int  = ImageView.scaled(Settings.Defaults.cellSize, scaling: Settings.Defaults.scaling)
    private var _cellSizeUS:    Int  = Settings.Defaults.cellSize

    // private var imageWidth:        Int { _imageWidthUS }
    // private var imageHeight:       Int { _imageHeightUS }
    // private var cellSize:          Int { _cellSizeUS }

    // private var imageWidthScaled:  Int { _imageWidth }
    // private var imageHeightScaled: Int { _imageHeight }
    // private var cellSizeScaled:    Int { _cellSize }

    public init(settings: Settings) {
        _settings = settings
    }

    public var image: CGImage { _image }
    public var size: CGSize { CGSize(width: _imageWidthUS, height: _imageHeightUS) }
    public var scale: CGFloat { _scaling ? Settings.Defaults.displayScale : 1.0 }

    public func update(viewSize: CGSize) {
        guard (viewSize.width > 0) && (viewSize.height > 0) else { return }
        self.setViewSize(viewSize, scaled: false) // Assume viewSize (from ContentView) is always unscaled
        self.update(contentViewUpdate: false)
    }

    public func update(cellSize: Int) {
        guard cellSize > 0 else { return }
        self.setCellSize(cellSize, scaled: _scaling)
        self.update(contentViewUpdate: true)
    }

    private func update(contentViewUpdate: Bool = true) {
        let preferred: CellGridView.PreferredSize = CellGridView.preferredSize(
            cellSize: _cellSize, viewWidth: _viewWidth, viewHeight: _viewHeight,
            fit: _cellFit, fitMarginMax: _settings.cellFitMarginMax)
        self.setImageSize(preferred.viewWidth, preferred.viewHeight, scaled: _scaling)
        self.setCellSize(preferred.cellSize, scaled: _scaling)
        self.updateImage(contentViewUpdate: contentViewUpdate)
    }

    private func updateImage(contentViewUpdate: Bool = true) {
        _image = self.createImage(imageWidth: _imageWidth, imageHeight: _imageHeight)
        if (contentViewUpdate) { _settings.contentView.updateImage() }
    }

    public func setupSettings() {
        //
        // Called by virtue of calling: _settings.contentView.showSettingsView()
        //
        _settings.cellSize = _cellSizeUS // Use unscaled in SettingsView
        _settings.cellFit = _cellFit
        _settings.cellColor = _cellColor
        _settings.scaling = _scaling
    }

    public func applySettings() {
        //
        // Called by virtue of calling: _settings.contentView.applySettings()
        //
        _scaling = _settings.scaling
        _cellFit = _settings.cellFit
        _cellColor = _settings.cellColor
        self.setCellSize(_settings.cellSize, scaled: false) // Use unscaled in SettingsView
        self.update(contentViewUpdate: true)
    }

    public func onZoom(_ zoomFactor: CGFloat) {
        if (_zoomStartCellSize == nil) { _zoomStartCellSize = _cellSize }
        let cellSize: Int = Int(CGFloat(_zoomStartCellSize!) * zoomFactor).clamped(1..._settings.cellSizeMax)
        self.update(cellSize: cellSize)
    }

    public func onZoomEnd(_ zoomFactor: CGFloat) {
        self.onZoom(zoomFactor) ; _zoomStartCellSize = nil
    }

    public func onSwipeLeft() {
        _settings.contentView.showSettingsView()
    }

    private func createImage(imageWidth: Int? = nil, imageHeight: Int? = nil, cellSize: Int? = nil) -> CGImage {

        let imageWidth:  Int = (imageWidth  ?? _imageWidth)
        let imageHeight: Int = (imageHeight ?? _imageHeight)
        let cellSize:    Int = (cellSize    ?? _cellSize)

        guard imageWidth > 0, imageHeight > 0 else { return DefaultImage.instance }
        let context = CGContext(data: nil, width: imageWidth, height: imageHeight,
                                bitsPerComponent: 8, bytesPerRow: imageWidth * Screen.channels,
                                space: DefaultImage.space, bitmapInfo: DefaultImage.bitmapInfo)!
        context.setFillColor(Colour.white.cgcolor)
        context.fill(CGRect(x: 0, y: 0, width: imageWidth, height: imageHeight))
        for y in stride(from: 0, to: imageHeight, by: cellSize) {
            for x in stride(from: 0, to: imageWidth, by: cellSize) {
                context.setFillColor((((x + y) / cellSize) % 2 == 0) ? _cellColor.cgcolor : Colour.white.cgcolor)
                context.fill(CGRect(x: x, y: y,
                                    width: min(cellSize, imageHeight - y > 0 ? cellSize : 0 + (imageWidth - x)),
                                    height: min(cellSize, imageHeight - y)))
            }
        }
        return context.makeImage()!
    }

    private func setViewSize(_ viewSize: CGSize, scaled: Bool = false) {
        guard (viewSize.width > 0) && (viewSize.height > 0) else { return }
        ImageView.setDimension(Int(floor(viewSize.width)), &_viewWidth, &_viewWidthUS, scaled: scaled, scaling: _scaling)
        ImageView.setDimension(Int(floor(viewSize.height)), &_viewHeight, &_viewHeightUS, scaled: scaled, scaling: _scaling)
    }

    private func setImageSize(_ imageWidth: Int, _ imageHeight: Int, scaled: Bool = false) {
        guard (imageWidth > 0) && (imageHeight > 0) else { return }
        ImageView.setDimension(imageWidth, &_imageWidth, &_imageWidthUS, scaled: scaled, scaling: _scaling)
        ImageView.setDimension(imageHeight, &_imageHeight, &_imageHeightUS, scaled: scaled, scaling: _scaling)
    }

    private func setCellSize(_ cellSize: Int, scaled: Bool = false) {
        ImageView.setDimension(cellSize, &_cellSize, &_cellSizeUS, scaled: scaled, scaling: _scaling)
    }

    private static func setDimension(_ value: Int, _ scaledValue: inout Int,
                                                   _ unscaledValue: inout Int, scaled: Bool, scaling: Bool) {
        (scaledValue, unscaledValue) = ImageView.scaler(value, scaled: scaled, scaling: scaling)
    }

    // Returns the scaled and unscaled values for the given value as a tuple (in that order),
    // based on whether or not the given value is scaled, and whether or not we are currently
    // in scaling mode (i.e. whether or not we want a scaled value as the scaled result).
    //
    private static func scaler(_ value: Int, scaled: Bool, scaling: Bool) -> (Int, Int) {
        if (scaled) {
            if (scaling) {
                return (value, ImageView.unscaled(value))
            }
            else {
                let unscaledValue: Int = ImageView.unscaled(value)
                return (unscaledValue, unscaledValue)
            }
        }
        else if (scaling) {
            return (ImageView.scaled(value), value)
        }
        else {
            return (value, value)
        }
    }

    private static func scaled(_ value: Int) -> Int { Int(round(CGFloat(value) * Settings.Defaults.displayScale)) }
    private static func scaled(_ value: Int, scaling: Bool) -> Int { scaling ? ImageView.scaled(value) : value }
    private static func unscaled(_ value: Int) -> Int { Int(round(CGFloat(value) / Settings.Defaults.displayScale)) }
    private static func unscaled(_ value: Int, scaling: Bool) -> Int { scaling ? ImageView.unscaled(value) : value }
}
