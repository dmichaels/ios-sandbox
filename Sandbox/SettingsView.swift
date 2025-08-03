import SwiftUI

public struct SettingsView: View {
    @EnvironmentObject private var settings: Settings
    @State private var anotherSettingsView = false
    public var body: some View {
        Form {
            Text("Settings ...")
            Toggle("Ignore Safe Area", isOn: $settings.ignoreSafeArea)
            Toggle("Hide Status Bar", isOn: $settings.hideStatusBar)
            Section {
                NavigationLink(destination: SettingsAdvancedView(), isActive: $anotherSettingsView) {
                    Label("Advanced Settings", systemImage: "gearshape.2")
                }
            }
        }
        .navigationTitle("Settings")
        .onDisappear {
            print("SettingsView.onDisappear> version: \(settings.version) anotherSettingsView: \(anotherSettingsView)")
            if (!anotherSettingsView) {
                print("SettingsView.onDisappear> UPDATE version: \(settings.version) anotherSettingsView: \(anotherSettingsView)")
                settings.version += 1
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
