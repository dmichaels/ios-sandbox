import SwiftUI
import Utils

public struct SettingsView: ImageContentView.SettingsViewable {

    @ObservedObject var settings: Settings
    @State private var anotherSettingsView: Bool = false

    public var body: some View {
        Form {
            Text("Settings ...")
            Toggle("Ignore Safe Area", isOn: $settings.contentView.ignoreSafeArea)
            Toggle("Hide Status Bar", isOn: $settings.contentView.hideStatusBar)
            Toggle("Hide Tool Bar", isOn: $settings.contentView.hideToolBar)
            Toggle("Large", isOn: $settings.large)
            HStack {
                IconLabel("Background", "COLOR")
                ColorPicker("", selection: $settings.contentView.background.picker)
            }
            HStack {
                IconLabel("Outer Square", "COLOR")
                ColorPicker("", selection: $settings.squareColor.picker)
            }
            HStack {
                IconLabel("Inner Square", "COLOR")
                ColorPicker("", selection: $settings.innerSquareColor.picker)
            }
            Section {
                NavigationLink(destination: SettingsAdvancedView(), isActive: $anotherSettingsView) {
                    Label("Advanced Settings", systemImage: "gearshape.2")
                }
            }
        }
        .navigationTitle("Settings")
        .onAppear {}
        .onDisappear {
            if (!self.anotherSettingsView) {
                settings.contentView.updateSettings()
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
