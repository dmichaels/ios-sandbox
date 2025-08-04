import SwiftUI

public class ImageView
{
    private var _width: Int = 0
    private var _height: Int = 0

    public var width: Int { self._width }
    public var height: Int { self._height }

    public func createImage(maxSize: CGSize, large: Bool = false) -> CGImage /*?*/ {
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
        return context.makeImage()!
    }
}
