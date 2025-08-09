import SwiftUI
import Utils

public struct SettingsView: ImageContentView.SettingsViewable {

    @EnvironmentObject var settings: Settings
    private let config: ImageContentView.Config
    @State private var hideStatusBar: Bool = false
    @State private var hideToolBar: Bool = false
    @State private var ignoreSafeArea: Bool = false
    @State private var anotherSettingsView: Bool = false

    init(_ config: ImageContentView.Config) {
        self.config = config
    }

    public var body: some View {
        Form {
            Text("Settings ...")
            Toggle("Ignore Safe Area", isOn: $ignoreSafeArea)
                .onChange(of: ignoreSafeArea) { config.ignoreSafeArea = ignoreSafeArea }
            Toggle("Hide Status Bar", isOn: $hideStatusBar)
                .onChange(of: hideStatusBar) { config.hideStatusBar = hideStatusBar }
            Toggle("Hide Tool Bar", isOn: $hideToolBar)
                .onChange(of: hideToolBar) { config.hideToolBar = hideToolBar }
            Section {
                NavigationLink(destination: SettingsAdvancedView(), isActive: $anotherSettingsView) {
                    Label("Advanced Settings", systemImage: "gearshape.2")
                }
            }
        }
        .navigationTitle("Settings")
        .onAppear {
            self.ignoreSafeArea = config.ignoreSafeArea
            self.hideToolBar = config.hideToolBar
            self.hideStatusBar = config.hideStatusBar
        }
        .onDisappear {
            if (!self.anotherSettingsView) {
                self.config.updateSettings()
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
