import SwiftUI
import Utils

public class ImageView: ImageContentView.Viewable
{
    public private(set) var image: CGImage = DummyImage.instance
    private var config: ImageContentView.Config
    private var backgroundColor: CGColor
    private var viewSize: CGSize = CGSize.zero
    private var imageSizeLarge = false

    required public init(_ config: ImageContentView.Config) {
        self.config = config
        self.backgroundColor = UIColor.red.cgColor
    }

    public func update(viewSize: CGSize) {
        self.image = self.createImage(viewSize: viewSize, large: self.imageSizeLarge)
    }

    public func onTap(_ point: CGPoint) {
        self.imageSizeLarge.toggle()
        self.image = self.createImage(viewSize: self.viewSize, large: self.imageSizeLarge)
        self.config.updateImage()
    }

    public func onLongTap(_ point: CGPoint?) {
        self.backgroundColor = UIColor.cyan.cgColor
        self.image = self.createImage()
        self.config.updateImage()
    }

    public func onZoom(_ zoomFactor: CGFloat) {
        var width: Int = Int(min(200 * zoomFactor, viewSize.width))
        var height: Int = Int(min(300 * zoomFactor, viewSize.height))
        self.image = self.createImage(width: width, height: height)
        self.config.updateImage()
    }

    public func onZoomEnd(_ zoomFactor: CGFloat) {
        self.onZoom(zoomFactor)
    }

    public func onSwipeLeft() {
        self.config.showSettingsView()
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
        context.setFillColor(UIColor.blue.cgColor)
        context.fill(CGRect(x: width / 2 - 10, y: 50, width: 20, height: 30))
        return context.makeImage()!
    }
}
