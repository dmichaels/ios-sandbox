import SwiftUI

public protocol ImageViewable
{
    init(_ config: ImageContentView.Config)
    var  image: CGImage { get }
    func update(viewSize: CGSize) -> CGImage
    func onTap(_ point: CGPoint)
    func onLongTap(_ point: CGPoint)
    func onDoubleTap(_ point: CGPoint?)
    func onDrag(_ point: CGPoint)
    func onDragEnd(_ point: CGPoint)
    var  onDragStrict: Bool { get }
    func onZoom(_ zoomFactor: CGFloat)
    func onZoomEnd(_ zoomFactor: CGFloat)
    func onSwipeLeft()
    func onSwipeRight()
}

extension ImageViewable {
    public func onTap(_ point: CGPoint) {}
    public func onLongTap(_ point: CGPoint) {}
    public func onDoubleTap(_ point: CGPoint?) {}
    public func onDrag(_ point: CGPoint) {}
    public func onDragEnd(_ point: CGPoint) {}
    public var  onDragStrict: Bool { false }
    public func onZoom(_ zoomFactor: CGFloat) {}
    public func onZoomEnd(_ zoomFactor: CGFloat) {}
    public func onSwipeLeft() {}
    public func onSwipeRight() {}
}
