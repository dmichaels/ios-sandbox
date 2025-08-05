import SwiftUI

public protocol ImageViewable
{
    func update(maxSize: CGSize, large: Bool, zoom: CGFloat?) -> CGImage
    var image: CGImage { get }
}
