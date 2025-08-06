import SwiftUI

public protocol ImageViewable
{
    init(_ settings: ContentView.Config)
    var image: CGImage { get }
    func update(maxSize: CGSize) -> CGImage
    func onTap(_ point: CGPoint)
    func onLongTap(_ point: CGPoint)
    func onDoubleTap(_ point: CGPoint?)
    func onDrag(_ point: CGPoint)
    func onDragEnd(_ point: CGPoint)
    func onZoom(_ zoomFactor: CGFloat)
    func onZoomEnd(_ zoomFactor: CGFloat)
}

extension ImageViewable {
    public func onTap(_ point: CGPoint) {}
    public func onLongTap(_ point: CGPoint) {}
    public func onDoubleTap(_ point: CGPoint?) {}
    public func onDrag(_ point: CGPoint) {}
    public func onDragEnd(_ point: CGPoint) {}
    public func onZoom(_ zoomFactor: CGFloat) {}
    public func onZoomEnd(_ zoomFactor: CGFloat) {}
}
