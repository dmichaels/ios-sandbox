import SwiftUI

public class ImageView: ImageViewable
{
    public private(set) var image: CGImage = DummyImage.instance
    private var config: ContentView.Config
    private var backgroundColor: CGColor
    private var imageSizeLarge = false
    private var maxSize: CGSize = CGSize.zero

    required public init(_ config: ContentView.Config) {
        self.config = config
        self.backgroundColor = UIColor.red.cgColor
    }

    public func update(maxSize: CGSize) -> CGImage {
        self.image = self.createImage(maxSize: maxSize, large: self.imageSizeLarge)
        return self.image
    }

    public func onTap(_ point: CGPoint) {
        self.imageSizeLarge.toggle()
        self.image = self.createImage(maxSize: self.maxSize, large: self.imageSizeLarge)
        self.config.updateImage()
    }

    public func onLongTap(_ point: CGPoint?) {
        self.backgroundColor = UIColor.cyan.cgColor
        self.image = self.createImage()
        self.config.updateImage()
    }

    public func onZoom(_ zoomFactor: CGFloat) {
        var width: Int = Int(min(200 * zoomFactor, maxSize.width))
        var height: Int = Int(min(300 * zoomFactor, maxSize.height))
        self.image = self.createImage(width: width, height: height)
        self.config.updateImage()
    }

    public func onZoomEnd(_ zoomFactor: CGFloat) {
        self.onZoom(zoomFactor)
    }

    public func onSwipeLeft() {
        self.config.showSettingsView()
    }

    private func createImage(maxSize: CGSize, large: Bool = false) -> CGImage {
        self.maxSize = maxSize
        let width = !large ? 200 : Int(maxSize.width)
        let height = !large ? 300 : Int(maxSize.height)
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
