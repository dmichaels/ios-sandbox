import SwiftUI

// TODO: still problem going to ignore safe area then back again to not - wrong image size ...
// try with old navigation scheme again in another branch ...

// Example (with help from ChatGPT) relevant to simplifying ios-lifegame setup 2027-07-31 ...
//
struct ContentView: View {

    @EnvironmentObject var settings: Settings
    @State private var image: CGImage? = nil
    @State private var imageSize: CGSize = .zero
    @State private var imageAngle: Angle = .zero
    @State private var imageSizeLarge = false
    @State private var containerSize: CGSize = .zero
    @State private var containerBackground: Color? = Color.yellow
    @State private var showSettingsView: Bool = false
    @State private var hideStatusBar: Bool = false
    @State private var ignoreSafeArea: Bool = false
    @StateObject private var orientation: OrientationObserver = OrientationObserver()

    var body: some View {
        //
        // A previous/alternate way of doing this, rather than using NavigationStack, is to
        // use NavigationView and then NavigationLink at the end of the inner ZStack like so:
        //
        //   NavigationLink(destination: SettingsView(), isActive: $showSettingsView){EmptyView()}.hidden()
        //
        // But this is deprecated; ChatGPT suggested using NavigationStack with .navigationDestination
        // on the inner ZStack; but this results in containerGeometry not getting set yet in .onAppear
        // on the inner ZStack, unless, as suggested by ChatGPT, we wrap the contents of teh .onAppear
        // in DispatchQueue.main.async, which it (ChatGPT) assures is me is reasonable and not weird.
        //
        NavigationStack {
            ZStack {
                containerBackground ?? Color.green // Important trickery here
                GeometryReader { containerGeometry in
                    ZStack {
                        if let image: CGImage = self.image {
                            Image(decorative: image, scale: 1.0)
                                .resizable()
                                .frame(width: CGFloat(image.width), height: CGFloat(image.height))
                                .position(x: containerGeometry.size.width / 2, y: containerGeometry.size.height / 2)
                                .rotationEffect(self.imageAngle)
                                .onSmartGesture(
                                    normalizePoint: self.normalizePoint, ignorePoint: self.ignorePoint,
                                    onTap: { imagePoint in
                                        print("TAP> \(imagePoint) is: \(self.imageSize.width)x\(self.imageSize.height) zg: \(containerGeometry.size) zs: \(containerSize) ssv: \(self.showSettingsView)")
                                        self.changeImage()
                                    },
                                    onSwipeLeft: { self.showSettingsView = true }
                                )
                        }
                    }
                    .onAppear {
                        DispatchQueue.main.async {
                            self.containerSize = containerGeometry.size
                            self.image = self.createImage(maxSize: self.containerSize, large: self.imageSizeLarge)
                            print("ZSTACK-ONAPPEAR> zg: \(containerGeometry.size) zs: \(self.containerSize.width)x\(self.containerSize.height) is: \(self.imageSize.width)x\(self.imageSize.height)")
                        }
                    }
                    .navigationDestination(isPresented: $showSettingsView) { SettingsView() }
                        .onChange(of: self.settings.version) {
                            self.updateSettings()
                        }
                }
            }
            .safeArea(ignore: ignoreSafeArea)
            .toolBar(hidden: ignoreSafeArea, showSettingsView: $showSettingsView)
        }
        .statusBar(hidden: hideStatusBar) // Needs to be here on NavigationStack to take unlike .safeArea and .toolBar
        .onAppear { self.orientation.register(self.updateOrientation) }
        .onDisappear { self.orientation.deregister() }
    }

    private func updateSettings() {
        hideStatusBar = self.settings.hideStatusBar
        ignoreSafeArea = self.settings.ignoreSafeArea
    }

    private func normalizePoint(_ containerPoint: CGPoint) -> CGPoint {
        let imageOrigin: CGPoint = CGPoint(
            x: (self.containerSize.width - self.imageSize.width) / 2,
            y: (self.containerSize.height - self.imageSize.height) / 2
        )
        return CGPoint(x: containerPoint.x - imageOrigin.x, y: containerPoint.y - imageOrigin.y)
    }

    private func ignorePoint(_ point: CGPoint) -> Bool {
        return (point.x < 0) || (point.y < 0) || (point.x >= self.imageSize.width) || (point.y >= self.imageSize.height)
    }

    private func rotateImage() {
        self.imageAngle = self.orientation.rotationAngle()
    }

    private func updateOrientation(_ current: UIDeviceOrientation, _ previous: UIDeviceOrientation) {
        self.rotateImage()
    }

    private func changeImage() {
        self.imageSizeLarge.toggle()
        self.image = self.createImage(maxSize: self.containerSize, large: self.imageSizeLarge)
        self.imageSize = CGSize(width: self.image!.width, height: self.image!.height)
    }

    private func createImage(maxSize: CGSize, large: Bool = false) -> CGImage? {
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
        let image: CGImage = context.makeImage()!
        self.imageSize = CGSize(width: image.width, height: image.height)
        print("CREATE-IMAGE> large: \(large) size: \(self.imageSize.width)x\(self.imageSize.height)")
        return image
    }
}

extension View {
    @ViewBuilder
    func toolBar(hidden: Bool, showSettingsView: Binding<Bool>) -> some View {
        if (hidden) { self } else { self.toolbar { ToolbarView(showSettingsView: showSettingsView) } }
    }
}
