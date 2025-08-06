import SwiftUI

// Example (with help from ChatGPT) relevant to simplifying ios-lifegame setup 2027-07-31 ...
// Went through lots of iterations; this is the simplest we came up with; lots of subtleties.
//
public struct ContentView: View
{
    public class Config: ObservableObject {

        @Published public var hideStatusBar: Bool = true
        @Published public var hideToolBar: Bool = false
        @Published public var ignoreSafeArea: Bool = false

        public func updateImage()      { self.versionImage += 1 }
        public func updateSettings()   { self.versionSettings += 1 }
        public func showSettingsView() { self.versionSettingsView += 1 }

        @Published internal private(set) var versionImage: Int = 0
        @Published internal private(set) var versionSettings: Int = 0
        @Published internal private(set) var versionSettingsView: Int = 0

        internal static let Defaults: Config = Config()
    }

    @EnvironmentObject private var config: ContentView.Config
                       private var settingsView: SettingsView
                       private var toolbarView: ToolbarView
                       private var imageView: ImageViewable
    @State             private var image: CGImage                   = DummyImage.instance
    @State             private var imageAngle: Angle                = .zero
    @State             private var containerSize: CGSize            = .zero
    @State             private var containerBackground: Color?      = Color.yellow
    @StateObject       private var orientation: OrientationObserver = OrientationObserver()
    @State             private var showSettingsView: Bool           = false
    @State             private var hideStatusBar: Bool              = ContentView.Config.Defaults.hideStatusBar
    @State             private var hideToolBar: Bool                = ContentView.Config.Defaults.hideToolBar
    @State             private var ignoreSafeArea: Bool             = ContentView.Config.Defaults.ignoreSafeArea

    public init(imageView: ImageView, settingsView: SettingsView, toolbarView: ToolbarView) {
        self.imageView = imageView
        self.settingsView = settingsView
        self.toolbarView = toolbarView
    }

    public var body: some View {
        NavigationStack {
            GeometryReader { containerGeometry in ZStack {
                containerBackground ?? Color.green // Important trickery here
                Image(decorative: self.image, scale: 1.0)
                    .resizable().frame(width: CGFloat(image.width), height: CGFloat(image.height))
                    .position(x: containerGeometry.size.width / 2, y: containerGeometry.size.height / 2)
                    .rotationEffect(self.imageAngle)
                }
                .onSmartGesture(
                    normalizePoint: self.normalizePoint,
                    ignorePoint:    self.ignorePoint,
                    onTap:          { imagePoint in self.imageView.onTap(imagePoint) },
                    onLongTap:      { imagePoint in self.imageView.onLongTap(imagePoint) },
                    onDoubleTap:    { imagePoint in self.imageView.onDoubleTap(imagePoint) },
                    onDrag:         { imagePoint in self.imageView.onDrag(imagePoint) },
                    onDragEnd:      { imagePoint in self.imageView.onDragEnd(imagePoint) },
                    onDragStrict:   self.imageView.onDragStrict,
                    onZoom:         { zoomFactor in self.imageView.onZoom(zoomFactor) },
                    onZoomEnd:      { zoomFactor in self.imageView.onZoomEnd(zoomFactor) },
                    onSwipeLeft:    { self.imageView.onSwipeLeft() },
                    onSwipeRight:   { self.imageView.onSwipeRight() }
                )
                .onAppear                                      { self.updateImage(geometry: containerGeometry) }
                .onChange(of: containerGeometry.size)          { self.updateImage(geometry: containerGeometry) }
                .onChange(of: self.config.versionSettings)     { self.updateSettings() }
                .onChange(of: self.config.versionSettingsView) { self.showSettingsView = true }
                .onChange(of: self.config.versionImage)        { self.image = self.imageView.image }
                .navigationDestination(isPresented: $showSettingsView) { self.settingsView }
            }
            .safeArea(ignore: self.ignoreSafeArea)
            // .toolBar(hidden: self.hideToolBar || self.ignoreSafeArea, showSettingsView: $showSettingsView)
            .toolBar(hidden: self.hideToolBar || self.ignoreSafeArea, toolbarView)
        }
        .statusBar(hidden: self.hideStatusBar)
        .onAppear    { self.orientation.register(self.updateOrientation) }
        .onDisappear { self.orientation.deregister() }
    }

    private func updateImage(geometry: GeometryProxy) {
        self.containerSize = geometry.size
        self.image = self.imageView.update(maxSize: self.containerSize)
    }

    private func updateOrientation(_ current: UIDeviceOrientation, _ previous: UIDeviceOrientation) {
        self.imageAngle = self.orientation.rotationAngle()
    }

    private func normalizePoint(_ point: CGPoint) -> CGPoint {
        return CGPoint(x: point.x - ((self.containerSize.width  - CGFloat(self.image.width))  / 2),
                       y: point.y - ((self.containerSize.height - CGFloat(self.image.height)) / 2))
    }

    private func ignorePoint(_ normalizedPoint: CGPoint) -> Bool {
        return (normalizedPoint.x < 0) || (normalizedPoint.x >= CGFloat(self.image.width))
            || (normalizedPoint.y < 0) || (normalizedPoint.y >= CGFloat(self.image.height))
    }

    private func updateSettings() {
        self.hideStatusBar = self.config.hideStatusBar
        self.hideToolBar = self.config.hideToolBar
        self.ignoreSafeArea = self.config.ignoreSafeArea
    }
}

extension View {
    @ViewBuilder
    internal func toolBar(hidden: Bool, _ toolbarView: ToolbarView) -> some View {
        if (hidden) { self } else { self.toolbar { toolbarView } }
    }
}
