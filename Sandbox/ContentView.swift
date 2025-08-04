import SwiftUI

// Example (with help from ChatGPT) relevant to simplifying ios-lifegame setup 2027-07-31 ...
// Went through lots of iterations; this is the simplest we came up with; lots of subtleties.
//
struct ContentView: View {

    @EnvironmentObject   var settings: Settings
    @State private       var image: CGImage = DummyImage.instance
    @State private       var imageView: ImageView = ImageView()
    @State private       var imageAngle: Angle = .zero
    @State private       var imageSizeLarge = false
    @State private       var containerSize: CGSize = .zero
    @State private       var containerBackground: Color? = Color.yellow
    @State private       var showSettingsView: Bool = false
    @State private       var hideStatusBar: Bool = Settings.Defaults.hideStatusBar
    @State private       var ignoreSafeArea: Bool = Settings.Defaults.ignoreSafeArea
    @StateObject private var orientation: OrientationObserver = OrientationObserver()

    internal var body: some View {
        NavigationStack {
            GeometryReader { containerGeometry in ZStack {
                containerBackground ?? Color.green // Important trickery here
                    Image(decorative: self.image, scale: 1.0)
                        .resizable()
                        .frame(width: CGFloat(image.width), height: CGFloat(image.height))
                        .position(x: containerGeometry.size.width / 2, y: containerGeometry.size.height / 2)
                        .rotationEffect(self.imageAngle)
                        .onSmartGesture(
                            normalizePoint: self.normalizePoint,
                            ignorePoint: self.ignorePoint,
                            onTap: { imagePoint in self.updateImage(toggle: true) },
                            onZoom: { zoomFactor in self.updateImage(zoom: zoomFactor) },
                            onSwipeLeft: { self.showSettingsView = true }
                        )
                }
                .onAppear {
                    if (self.containerSize != containerGeometry.size) {
                        self.containerSize = containerGeometry.size
                        self.updateImage()
                    }
                }
                .onChange(of: containerGeometry.size) {
                    if (self.containerSize != containerGeometry.size) {
                        self.containerSize = containerGeometry.size
                        self.updateImage()
                    }
                }
                .navigationDestination(isPresented: $showSettingsView) { SettingsView() }
                    .onChange(of: self.settings.version) { self.updateSettings() }
            }
            .safeArea(ignore: ignoreSafeArea)
            .toolBar(hidden: ignoreSafeArea, showSettingsView: $showSettingsView)
        }
        .statusBar(hidden: hideStatusBar)
        .onAppear { self.orientation.register(self.updateOrientation) }
        .onDisappear { self.orientation.deregister() }
    }

    private func updateSettings() {
        hideStatusBar = self.settings.hideStatusBar
        ignoreSafeArea = self.settings.ignoreSafeArea
    }

    private func updateImage(toggle: Bool = false, zoom: CGFloat? = nil) {
        if (toggle) { self.imageSizeLarge.toggle() }
        self.image = self.imageView.update(maxSize: self.containerSize, large: self.imageSizeLarge, zoom: zoom)
    }

    private func rotateImage() {
        self.imageAngle = self.orientation.rotationAngle()
    }

    private func updateOrientation(_ current: UIDeviceOrientation, _ previous: UIDeviceOrientation) {
        self.rotateImage()
    }

    private func normalizePoint(_ point: CGPoint) -> CGPoint {
        return CGPoint(x: point.x - ((self.containerSize.width  - CGFloat(self.image.width))  / 2),
                       y: point.y - ((self.containerSize.height - CGFloat(self.image.height)) / 2))
    }

    private func ignorePoint(_ normalizedPoint: CGPoint) -> Bool {
        return (normalizedPoint.x < 0) || (normalizedPoint.x >= CGFloat(self.image.width))
            || (normalizedPoint.y < 0) || (normalizedPoint.y >= CGFloat(self.image.height))
    }
}

extension View {
    @ViewBuilder
    internal func toolBar(hidden: Bool, showSettingsView: Binding<Bool>) -> some View {
        if (hidden) { self } else { self.toolbar { ToolbarView(showSettingsView: showSettingsView) } }
    }
}
