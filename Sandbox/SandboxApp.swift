import SwiftUI

@main
struct SandboxApp: App {
    var settings: ContentView.Settings = ContentView.Settings()
    var body: some Scene {
        WindowGroup {
            ContentView(ImageView(settings))
                .environmentObject(settings)
        }
    }
}
