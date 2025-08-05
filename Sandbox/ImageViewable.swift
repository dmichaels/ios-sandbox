import SwiftUI

public protocol ImageViewable
{
    init(_ settings: ContentView.Settings)
    var image: CGImage { get }
    func update(maxSize: CGSize, large: Bool, zoom: CGFloat?) -> CGImage
    func onTap(_ point: CGPoint)
    func onLongTap(_ point: CGPoint)
    func onDoubleTap(_ point: CGPoint?)
    func onDrag(_ point: CGPoint)
    func onDragEnd(_ point: CGPoint)
    func onZoom(_ factor: CGFloat)
    func onZoomEnd(_ factor: CGFloat)
}

extension ImageViewable {
    public func onTap(_ point: CGPoint) {}
    public func onLongTap(_ point: CGPoint) {}
    public func onDoubleTap(_ point: CGPoint?) {}
    public func onDrag(_ point: CGPoint) {}
    public func onDragEnd(_ point: CGPoint) {}
    public func onZoom(_ factor: CGFloat) {}
    public func onZoomEnd(_ factor: CGFloat) {}
}
