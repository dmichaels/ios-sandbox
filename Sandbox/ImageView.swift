import SwiftUI
import Utils

public class ImageView: ImageContentView.Viewable
{
    private var settings: Settings!
    public private(set) var image: CGImage = DummyImage.instance
    private var backgroundColor: CGColor
    private var viewSize: CGSize = CGSize.zero
    private var imageSizeLarge = false
    private var zoomStart: CGSize? = nil

    public init(settings: Settings) {
        self.settings = settings
        self.backgroundColor = Colour.red.cgcolor
    }

    public func update(viewSize: CGSize) {
        self.image = self.createImage(viewSize: viewSize, large: self.imageSizeLarge)
    }

    public func onTap(_ point: CGPoint) {
        self.imageSizeLarge.toggle()
        self.image = self.createImage(viewSize: self.viewSize, large: self.imageSizeLarge)
        self.settings.contentView.updateImage()
    }

    public func onLongTap(_ point: CGPoint) {
        self.backgroundColor = UIColor.cyan.cgColor
        self.image = self.createImage()
        self.settings.contentView.updateImage()
    }

    public func onZoom(_ zoomFactor: CGFloat) {
        if (self.zoomStart == nil) {
            self.zoomStart = CGSize(width: image.width, height: image.height)
        }
        let width: Int = (CGFloat(self.zoomStart!.width) * zoomFactor).clampedInt(1.0...viewSize.width)
        let height: Int = (CGFloat(self.zoomStart!.height) * zoomFactor).clampedInt(1.0...viewSize.height)
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

    private func createImage(viewSize: CGSize, large: Bool = false) -> CGImage {
        self.viewSize = viewSize
        let width = !large ? 200 : Int(viewSize.width)
        let height = !large ? 300 : Int(viewSize.height)
        return self.createImage(width: width, height: height)
    }

    private func createImage(width: Int? = nil, height: Int? = nil) -> CGImage {
        let width: Int = width ?? self.image.width
        let height: Int = height ?? self.image.height
        let context = CGContext(
            data: nil, width: width, height: height,
            bitsPerComponent: 8, bytesPerRow: width * 4, space: CGColorSpaceCreateDeviceRGB(),
            bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
        )!
        context.setFillColor(self.backgroundColor)
        context.fill(CGRect(x: 0, y: 0, width: width, height: height))
        context.translateBy(x: 0, y: CGFloat(height))
        context.scaleBy(x: 1.0, y: -1.0)
        context.setFillColor(self.settings.squareColor.cgcolor)
        let innerRectangleWidth: Int = self.settings.large ? 100 : 20
        let innerRectangleHeight: Int = self.settings.large ? 150 : 30
        context.fill(CGRect(x: (width - innerRectangleWidth) / 2, y: (height - innerRectangleHeight) / 2,
                            width: innerRectangleWidth, height: innerRectangleHeight))
        return context.makeImage()!
    }
}
