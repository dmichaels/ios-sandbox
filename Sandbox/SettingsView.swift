import SwiftUI

public struct SettingsView: View {
    @EnvironmentObject private var settings: Settings
    public var body: some View {
        Form {
            Text("Settings ...")
            Toggle("Ignore Safe Area", isOn: $settings.ignoreSafeArea)
            Toggle("Hide Status Bar", isOn: $settings.hideStatusBar)
            Section {
                NavigationLink(destination: SettingsAdvancedView()) {
                    Label("Advanced Settings", systemImage: "gearshape.2")
                }
            }
        }
        .navigationTitle("Settings")
        .onDisappear { settings.version += 1 }
    }
}

public struct SettingsAdvancedView: View {
    public var body: some View {
        Form {
            Text("Advanced Settings ...")
        }
        .navigationTitle("Advanced")
    }
}
