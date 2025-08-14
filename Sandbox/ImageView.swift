import SwiftUI
import CellGridView
import Utils

public class ImageView: ImageContentView.Viewable
{
    private var cellGridView: CellGridView = CellGridView()
    private var settings: Settings // !
    public private(set) var image: CGImage = DummyImage.instance
    private var viewWidth: Int = 0
    private var viewHeight: Int = 0
    private var zoomStartCellSize: Int? = nil
    private var cellSize: Int
    private var cellFit: CellGridView.Fit
    private var cellColor: Colour

    public init(settings: Settings) {
        self.settings = settings
        self.cellSize = settings.cellSize
        self.cellFit = settings.cellFit
        self.cellColor = settings.cellColor
    }

    public func update(viewSize: CGSize) {
        guard (viewSize.width > 0) && (viewSize.height > 0) else { return }
        let viewWidth:  Int = Int(viewSize.width)
        let viewHeight: Int = Int(viewSize.height)
        guard (viewWidth != self.viewWidth) || (viewHeight != self.viewHeight) else { return }
        self.viewWidth  = viewWidth
        self.viewHeight = viewHeight
        self.update()
    }

    public func update(cellSize: Int) {
        guard (cellSize > 0) && (cellSize != self.cellSize) else { return }
        self.cellSize = cellSize
        self.update(contentViewUpdate: true)
    }

    private func update(contentViewUpdate: Bool = false) {
        let preferred: CellGridView.PreferredSize = CellGridView.preferredSize(
            cellSize: self.cellSize, viewWidth: self.viewWidth, viewHeight: self.viewHeight,
            fit: self.cellFit, fitMarginMax: self.settings.cellFitMarginMax)
        self.cellSize = preferred.cellSize
        self.image = self.createImage(imageWidth: preferred.viewWidth, imageHeight: preferred.viewHeight)
        if (contentViewUpdate) { self.settings.contentView.updateImage() }
    }

    public func setupSettings() {
        self.settings.cellSize = self.cellSize
        self.settings.cellFit = self.cellFit
        self.settings.cellColor = self.cellColor
    }

    public func applySettings() {
        self.cellColor = self.settings.cellColor
        self.cellSize = self.settings.cellSize
        self.update(contentViewUpdate: true)
    }

    public func onTap(_ point: CGPoint) {
        print("ImageView.onTap> \(point.x),\(point.y)")
    }

    public func onZoom(_ zoomFactor: CGFloat) {
        if (self.zoomStartCellSize == nil) { self.zoomStartCellSize = self.cellSize }
        self.update(cellSize: Int(CGFloat(self.zoomStartCellSize!) * zoomFactor).clamped(1...self.settings.cellSizeMax))
    }

    public func onZoomEnd(_ zoomFactor: CGFloat) {
        self.onZoom(zoomFactor) ; self.zoomStartCellSize = nil
    }

    public func onSwipeLeft() {
        self.settings.contentView.showSettingsView()
    }

    private func createImage(imageWidth: Int? = nil, imageHeight: Int? = nil, cellSize: Int? = nil) -> CGImage {
        let imageWidth:  Int = imageWidth  ?? self.image.width
        let imageHeight: Int = imageHeight ?? self.image.height
        let cellSize:    Int = cellSize    ?? self.cellSize
        guard imageWidth > 0, imageHeight > 0 else { return DummyImage.instance }
        let context = CGContext(data: nil, width: imageWidth, height: imageHeight,
                                bitsPerComponent: 8, bytesPerRow: imageWidth * 4, space: CGColorSpaceCreateDeviceRGB(),
                                bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)!
        context.setFillColor(Colour.white.cgcolor)
        context.fill(CGRect(x: 0, y: 0, width: imageWidth, height: imageHeight))
        for y in stride(from: 0, to: imageHeight, by: cellSize) {
            for x in stride(from: 0, to: imageWidth, by: cellSize) {
                let black: Bool = ((x / cellSize) + (y / cellSize)) % 2 == 0
                context.setFillColor(black ? self.cellColor.cgcolor : Colour.white.cgcolor)
                context.fill(CGRect(x: x, y: y,
                                    width: min(cellSize, imageHeight - y > 0 ? cellSize : 0 + (imageWidth - x)),
                                    height: min(cellSize, imageHeight - y)))
            }
        }
        return context.makeImage()!
    }
}
