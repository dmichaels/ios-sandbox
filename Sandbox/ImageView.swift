import SwiftUI
import Utils
import CellGridView

public class ImageView: ImageContentView.Viewable
{
    private var cellGridView: CellGridView = CellGridView()
    private var settings: Settings!
    public private(set) var image: CGImage = DummyImage.instance
    private var viewWidth: Int = 0
    private var viewHeight: Int = 0
    private var zoomStart: CGSize? = nil

    public init(settings: Settings) {
        self.settings = settings
    }

    public func update(viewSize: CGSize) {
        let viewWidth: Int = Int(viewSize.width)
        let viewHeight: Int = Int(viewSize.height)
        if ((viewWidth != self.viewWidth) || (viewHeight != self.viewHeight)) {
            self.viewWidth = max(viewWidth, 1)
            self.viewHeight = max(viewHeight, 1)
            let imageSize = self.preferredImageSize(viewWidth: self.viewWidth, viewHeight: self.viewHeight)
            self.image = self.createImage(width: imageSize.width, height: imageSize.height)
        }

        let cellSize: Int = 43
        let preferredSize = CellGridView.preferredSize(cellSize: cellSize,
                                                       viewWidth: self.viewWidth,
                                                       viewHeight: self.viewHeight,
                                                       fit: CellGridView.Fit.enabled,
                                                       fitMarginMax: 100)
        var x = 1
    }

    public func onTap(_ point: CGPoint) {
        self.settings.squareSizeSmall.toggle()
        let imageSize = self.preferredImageSize(viewWidth: self.viewWidth, viewHeight: self.viewHeight)
        self.image = self.createImage(width: imageSize.width, height: imageSize.height)
        self.settings.contentView.updateImage()
    }

    public func onLongTap(_ point: CGPoint) {
        self.settings.squareColor = Colour.cyan
        self.image = self.createImage()
        self.settings.contentView.updateImage()
    }

    public func onZoom(_ zoomFactor: CGFloat) {
        if (self.zoomStart == nil) { self.zoomStart = CGSize(width: image.width, height: image.height) }
        let width: Int = Int(CGFloat(self.zoomStart!.width) * zoomFactor).clamped(1...self.viewWidth)
        let height: Int = Int(CGFloat(self.zoomStart!.height) * zoomFactor).clamped(1...self.viewHeight)
        self.image = self.createImage(width: width, height: height)
        self.settings.contentView.updateImage()
    }

    public func onZoomEnd(_ zoomFactor: CGFloat) {
        self.onZoom(zoomFactor)
        self.zoomStart = nil
    }

    public func onSwipeLeft() {
        self.settings.contentView.showSettingsView()
    }

    private func preferredImageSize(viewWidth: Int, viewHeight: Int) -> (width: Int, height: Int) {
        return (width:  (self.settings.squareSizeSmall ? 200 : Int(viewWidth)).clamped(1...viewWidth),
                height: (self.settings.squareSizeSmall ? 300 : Int(viewHeight)).clamped(1...viewHeight))
    }

    private func createImage(width: Int? = nil, height: Int? = nil) -> CGImage {
        let width: Int = width ?? self.image.width
        let height: Int = height ?? self.image.height
        guard width > 0, height > 0 else {
            return DummyImage.instance
        }
        let context = CGContext(data: nil, width: width, height: height,
                                bitsPerComponent: 8, bytesPerRow: width * 4, space: CGColorSpaceCreateDeviceRGB(),
                                bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)!
        context.setFillColor(self.settings.squareColor.cgcolor)
        context.fill(CGRect(x: 0, y: 0, width: width, height: height))
        context.translateBy(x: 0, y: CGFloat(height))
        context.scaleBy(x: 1.0, y: -1.0)
        context.setFillColor(self.settings.innerSquareColor.cgcolor)
        let innerRectangleWidth: Int = width / 3
        let innerRectangleHeight: Int = height / 3
        context.fill(CGRect(x: (width - innerRectangleWidth) / 2, y: (height - innerRectangleHeight) / 2,
                            width: innerRectangleWidth, height: innerRectangleHeight))
        let image: CGImage? = context.makeImage()
        return image!
    }
}
