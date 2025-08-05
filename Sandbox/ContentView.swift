import SwiftUI

// Example (with help from ChatGPT) relevant to simplifying ios-lifegame setup 2027-07-31 ...
// Went through lots of iterations; this is the simplest we came up with; lots of subtleties.
//
public struct ContentView: View
{
    public class Settings: ObservableObject {

        @Published public var hideStatusBar: Bool = true
        @Published public var hideToolBar: Bool = false
        @Published public var ignoreSafeArea: Bool = false
        @Published public var versionSettings: Int = 0
        @Published public var versionImage: Int = 0

        public func updateSettings() { self.versionSettings += 1 }
        public func updateImage()    { self.versionImage += 1 }

        public static let Defaults: Settings = Settings()
    }

    @EnvironmentObject private var settings: ContentView.Settings
                       private var imageView: ImageViewable
    @State             private var image: CGImage                   = DummyImage.instance
    @State             private var imageAngle: Angle                = .zero
    @State             private var containerSize: CGSize            = .zero
    @State             private var containerBackground: Color?      = Color.yellow
    @StateObject       private var orientation: OrientationObserver = OrientationObserver()
    @State             private var showSettingsView: Bool           = false
    @State             private var hideStatusBar: Bool              = ContentView.Settings.Defaults.hideStatusBar
    @State             private var hideToolBar: Bool                = ContentView.Settings.Defaults.hideToolBar
    @State             private var ignoreSafeArea: Bool              = ContentView.Settings.Defaults.ignoreSafeArea

    internal init(_ imageView: ImageView) {
        self.imageView = imageView
    }

    public var body: some View {
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
                            onTap:     { imagePoint in self.imageView.onTap(imagePoint) },
                            onLongTap: { imagePoint in self.imageView.onLongTap(imagePoint) },
                            onZoom:    { zoomFactor in self.imageView.onZoom(zoomFactor) },
                            onSwipeLeft: { self.showSettingsView = true }
                        )
                }
                .onAppear {
                    self.updateImage(geometry: containerGeometry)
                }
                .onChange(of: containerGeometry.size) {
                    self.updateImage(geometry: containerGeometry)
                }
                .onChange(of: self.settings.versionSettings) {
                    self.updateSettings()
                }
                .onChange(of: self.settings.versionImage) {
                    self.image = self.imageView.image
                }
                .navigationDestination(isPresented: $showSettingsView) { SettingsView() }
            }
            .safeArea(ignore: ignoreSafeArea)
            .toolBar(hidden: hideToolBar || ignoreSafeArea, showSettingsView: $showSettingsView)
        }
        .statusBar(hidden: hideStatusBar)
        .onAppear { self.orientation.register(self.updateOrientation) }
        .onDisappear { self.orientation.deregister() }
    }

    private func updateSettings() {
        hideStatusBar = self.settings.hideStatusBar
        hideToolBar = self.settings.hideToolBar
        ignoreSafeArea = self.settings.ignoreSafeArea
    }

    private func updateImage(geometry: GeometryProxy? = nil) {
        if let geometry: GeometryProxy = geometry, self.containerSize != geometry.size {
            self.containerSize = geometry.size
        }
        self.image = self.imageView.update(maxSize: self.containerSize)
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
