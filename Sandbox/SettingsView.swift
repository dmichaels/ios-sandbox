import SwiftUI

public struct SettingsView: View {
    @EnvironmentObject private var settings: ContentView.Settings
    @State private var anotherSettingsView = false
    public var body: some View {
        Form {
            Text("Settings ...")
            Toggle("Ignore Safe Area", isOn: $settings.ignoreSafeArea)
            Toggle("Hide Status Bar", isOn: $settings.hideStatusBar)
            Toggle("Hide Toolbar Bar", isOn: $settings.hideToolBar)
            Section {
                NavigationLink(destination: SettingsAdvancedView(), isActive: $anotherSettingsView) {
                    Label("Advanced Settings", systemImage: "gearshape.2")
                }
            }
        }
        .navigationTitle("Settings")
        .onDisappear {
            if (!self.anotherSettingsView) {
                self.settings.version += 1
            }
        }
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
