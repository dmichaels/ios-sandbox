import SwiftUI

public class DummyImage {
    public static let instance: CGImage = {
        print("DUMMY-IMAGE")
        return CGContext(
            data: nil, width: 1, height: 1, bitsPerComponent: 8, bytesPerRow: 4,
            space: CGColorSpaceCreateDeviceRGB(), bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
        )!.makeImage()!
    }()
}
