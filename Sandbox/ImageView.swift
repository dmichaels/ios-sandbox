import SwiftUI

public class ImageView
{
    private var _image: CGImage = DummyImage.instance
    public var image: CGImage { self._image }

    public func update(maxSize: CGSize, large: Bool = false) -> CGImage {
        self._image = self.createImage(maxSize: maxSize, large: large)
        return self._image
    }

    private func createImage(maxSize: CGSize, large: Bool = false) -> CGImage /*?*/ {
        let width = !large ? 200 : Int(maxSize.width)
        let height = !large ? 300 : Int(maxSize.height)
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
        print("CREATE-IMAGE: \(width)x\(height)")
        return context.makeImage()!
    }
}
