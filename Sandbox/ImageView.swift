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
    private var zoomStart: CGSize? = nil
    private var zoomCellSizeStart: Int? = nil

    private var cellSize: Int
    private var cellFit: CellGridView.Fit
    private var cellColor: Colour = Colour.black

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
        let preferredSize: CellGridView.PreferredSize = CellGridView.preferredSize(
            cellSize: self.cellSize,
            viewWidth: self.viewWidth,
            viewHeight: self.viewHeight,
            fit: self.cellFit,
            fitMarginMax: self.settings.cellFitMarginMax)
        let imageWidth:  Int = preferredSize.viewWidth
        let imageHeight: Int = preferredSize.viewHeight
        self.cellSize = preferredSize.cellSize
        self.image = self.createImage(width: imageWidth, height: imageHeight)
        if (contentViewUpdate) { self.settings.contentView.updateImage() }
    }

    public func updateSettings() {
        self.cellColor = settings.cellColor
        self.cellSize = settings.cellSize
        self.update(contentViewUpdate: true)
    }

    public func onShowSettingsView() {
        settings.cellSize = self.cellSize
        settings.cellFit = self.cellFit
        settings.cellColor = self.cellColor
    }

    public func onTap(_ point: CGPoint) { }
    public func onLongTap(_ point: CGPoint) { }

    public func onZoom(_ zoomFactor: CGFloat) {
        if (self.zoomCellSizeStart == nil) { self.zoomCellSizeStart = self.cellSize }
        self.update(cellSize: Int(CGFloat(self.zoomCellSizeStart!) * zoomFactor).clamped(1...self.settings.cellSizeMax))
        // self.cellSize = Int(CGFloat(self.zoomCellSizeStart!) * zoomFactor).clamped(1...self.settings.cellSizeMax)
        // self.update(contentViewUpdate: true)
    }

    public func onZoomEnd(_ zoomFactor: CGFloat) {
        self.onZoom(zoomFactor)
        self.zoomStart = nil
    }

    public func onSwipeLeft() {
        self.settings.contentView.showSettingsView()
    }

    private func createImage(width: Int? = nil, height: Int? = nil, cellSize: Int? = nil) -> CGImage {
        let width:    Int = width  ?? image.width
        let height:   Int = height ?? image.height
        let cellSize: Int = cellSize ?? self.cellSize
        guard width > 0, height > 0 else { return DummyImage.instance }
        let context = CGContext(data: nil, width: width, height: height,
                                bitsPerComponent: 8, bytesPerRow: width * 4, space: CGColorSpaceCreateDeviceRGB(),
                                bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)!
        context.setFillColor(Colour.white.cgcolor)
        context.fill(CGRect(x: 0, y: 0, width: width, height: height))
        for y in stride(from: 0, to: height, by: cellSize) {
            for x in stride(from: 0, to: width, by: cellSize) {
                let isBlack = ((x / cellSize) + (y / cellSize)) % 2 == 0
                context.setFillColor(isBlack ? self.cellColor.cgcolor : Colour.white.cgcolor)
                context.fill(CGRect(x: x, y: y,
                                    width: min(cellSize, height - y > 0 ? cellSize : 0 + (width - x)),
                                    height: min(cellSize, height - y)))
            }
        }
        return context.makeImage()!
    }
}
