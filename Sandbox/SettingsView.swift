import SwiftUI

public struct SettingsView: View {
    @EnvironmentObject private var settings: Settings
    public var body: some View {
        Form {
            Text("Settings ...")
            Toggle("Ignore Safe Area", isOn: $settings.ignoreSafeArea)
            Toggle("Hide Status Bar", isOn: $settings.hideStatusBar)
        }
        .navigationTitle("Settings")
        .onDisappear { settings.version += 1 }
    }
}
