import SwiftUI

public class ImageView: ImageViewable
{
    public private(set) var image: CGImage = DummyImage.instance

    public func update(maxSize: CGSize, large: Bool = false, zoom: CGFloat? = nil) -> CGImage {
        if let zoom: CGFloat = zoom {
            var width: Int = Int(min(200 * zoom, maxSize.width))
            var height: Int = Int(min(300 * zoom, maxSize.height))
            self.image = self.createImage(width: width, height: height)
        }
        else {
            self.image = self.createImage(maxSize: maxSize, large: large)
        }
        return self.image
    }

    private func createImage(maxSize: CGSize, large: Bool = false) -> CGImage /*?*/ {
        let width = !large ? 200 : Int(maxSize.width)
        let height = !large ? 300 : Int(maxSize.height)
        return self.createImage(width: width, height: height)
    }

    private func createImage(width: Int, height: Int) -> CGImage /*?*/ {
        let context = CGContext(
            data: nil, width: width, height: height,
            bitsPerComponent: 8, bytesPerRow: width * 4, space: CGColorSpaceCreateDeviceRGB(),
            bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
        )!
        context.setFillColor(UIColor.red.cgColor)
        context.fill(CGRect(x: 0, y: 0, width: width, height: height))
        context.translateBy(x: 0, y: CGFloat(height))
        context.scaleBy(x: 1.0, y: -1.0)
        context.setFillColor(UIColor.blue.cgColor)
        context.fill(CGRect(x: width / 2 - 10, y: 50, width: 20, height: 30))
        return context.makeImage()!
    }
}
