import SwiftUI

// TODO: still problem going to ignore safe area then back again to not - wrong image size ...
// try with old navigation scheme again in another branch ...

// Example (with help from ChatGPT) relevant to simplifying ios-lifegame setup 2027-07-31 ...
//
struct ContentView: View {

    @EnvironmentObject var settings: Settings
    @State private var image: CGImage = DummyImage.instance
    @State private var imageView: ImageView = ImageView()
    @State private var imageAngle: Angle = .zero
    @State private var imageSizeLarge = false
    @State private var containerSize: CGSize = .zero
    @State private var containerBackground: Color? = Color.yellow
    @State private var showSettingsView: Bool = false
    @State private var hideStatusBar: Bool = Settings.Defaults.hideStatusBar
    @State private var ignoreSafeArea: Bool = Settings.Defaults.ignoreSafeArea
    @StateObject private var orientation: OrientationObserver = OrientationObserver()

    var body: some View {
        //
        // A previous/alternate way of doing this, rather than using NavigationStack, is to
        // use NavigationView and then NavigationLink at the end of the inner ZStack like so:
        //
        //   NavigationLink(destination: SettingsView(), isActive: $showSettingsView){EmptyView()}.hidden()
        //
        // But this is deprecated; ChatGPT suggested using NavigationStack with .navigationDestination
        // on the inner ZStack; but this results in geometryInner not getting set yet in .onAppear
        // on the inner ZStack, unless, as suggested by ChatGPT, we wrap the contents of teh .onAppear
        // in DispatchQueue.main.async, which it (ChatGPT) assures is me is reasonable and not weird.
        // And, we have to catch .onChange too.
        //
        NavigationStack {
            GeometryReader { _ in ZStack {
                containerBackground ?? Color.green // Important trickery here
                GeometryReader { geometryInner in ZStack { // Could also be VStack (?)
                    Image(decorative: self.image, scale: 1.0)
                        .resizable()
                        .frame(width: CGFloat(image.width), height: CGFloat(image.height))
                        .position(x: geometryInner.size.width / 2, y: geometryInner.size.height / 2)
                        .rotationEffect(self.imageAngle)
                        .contentShape(Rectangle())
                        .onSmartGesture(
                            normalizePoint: self.normalizePoint,
                            ignorePoint: self.ignorePoint,
                            onTap: { imagePoint in
                                print("TAP> \(imagePoint)")
                                self.updateImage(toggle: true)
                            },
                            onSwipeLeft: { self.showSettingsView = true }
                        )
                }
                .onAppear {
                    if (self.containerSize != geometryInner.size) {
                        print("ZSTACK-APPEAR> gs: \(geometryInner.size) cs: \(self.containerSize) is: \(self.image.width)x\(self.image.height)")
                        self.containerSize = geometryInner.size
                        self.updateImage()
                    }
                }
                .onChange(of: geometryInner.size) {
                    if (self.containerSize != geometryInner.size) {
                        print("ZSTACK-CHANGE> gs: \(geometryInner.size) cs: \(self.containerSize) is: \(self.image.width)x\(self.image.height)")
                        self.containerSize = geometryInner.size
                        self.updateImage()
                    }
                }
                .navigationDestination(isPresented: $showSettingsView) { SettingsView() }
                    .onChange(of: self.settings.version) {
                        self.updateSettings()
                    }
            }}
            .safeArea(ignore: ignoreSafeArea)
            .toolBar(hidden: ignoreSafeArea, showSettingsView: $showSettingsView)
        }}
        .statusBar(hidden: hideStatusBar) // Needs to be here on NavigationStack to take unlike .safeArea and .toolBar
        .onAppear { self.orientation.register(self.updateOrientation) }
        .onDisappear { self.orientation.deregister() }
    }

    private func updateSettings() {
        hideStatusBar = self.settings.hideStatusBar
        ignoreSafeArea = self.settings.ignoreSafeArea
    }

    private func updateImage(toggle: Bool = false) {
        if (toggle) { self.imageSizeLarge.toggle() }
        self.image = self.imageView.update(maxSize: self.containerSize, large: self.imageSizeLarge)
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

    private func ignorePoint(_ point: CGPoint) -> Bool {
        return (point.x < 0) || (point.x >= CGFloat(self.image.width))
            || (point.y < 0) || (point.y >= CGFloat(self.image.height))
    }
}

extension View {
    @ViewBuilder
    func toolBar(hidden: Bool, showSettingsView: Binding<Bool>) -> some View {
        if (hidden) { self } else { self.toolbar { ToolbarView(showSettingsView: showSettingsView) } }
    }
}
