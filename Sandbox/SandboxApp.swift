import SwiftUI

@main
struct SandboxApp: App {
    var settings: ContentView.Config = ContentView.Config()
    var body: some Scene {
        WindowGroup {
            ContentView(ImageView(settings))
                .environmentObject(settings)
        }
    }
}
