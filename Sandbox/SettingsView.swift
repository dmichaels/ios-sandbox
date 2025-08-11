import SwiftUI
import Utils

public struct SettingsView: ImageContentView.SettingsViewable {

    @ObservedObject var settings: Settings
    @State private var hideStatusBar: Bool = false
    @State private var hideToolBar: Bool = false
    @State private var ignoreSafeArea: Bool = false
    @State private var anotherSettingsView: Bool = false
    @State private var background: Color = .white
    @State private var squareColor: Color = .white

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
                IconLabel("Square Color", "cOLOR")
                ColorPicker("", selection: $settings.squareColor.picker)
            }
            Section {
                NavigationLink(destination: SettingsAdvancedView(), isActive: $anotherSettingsView) {
                    Label("Advanced Settings", systemImage: "gearshape.2")
                }
            }
        }
        .navigationTitle("Settings")
        .onAppear {
            self.ignoreSafeArea = settings.contentView.ignoreSafeArea
            self.hideToolBar = settings.contentView.hideToolBar
            self.hideStatusBar = settings.contentView.hideStatusBar
            self.background = settings.contentView.background.color
            self.squareColor = settings.squareColor.color
        }
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
