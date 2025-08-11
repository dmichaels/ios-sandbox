import SwiftUI
import Utils

public struct SettingsView: ImageContentView.SettingsViewable {

    @ObservedObject var settings: Settings
    // @State private var settings: Settings
    @State private var hideStatusBar: Bool = false
    @State private var hideToolBar: Bool = false
    @State private var ignoreSafeArea: Bool = false
    @State private var anotherSettingsView: Bool = false
    @State private var background: Color = .white
    @State private var squareColor: Color = .white

    /*
    init(_ settings: Settings) {
        // self.settings = settings
    }
    */

    public var body: some View {
        Form {
            Text("Settings ...")
            Toggle("Ignore Safe Area", isOn: $settings.config.ignoreSafeArea)
            Toggle("Hide Status Bar", isOn: $settings.config.hideStatusBar)
            Toggle("Hide Tool Bar", isOn: $settings.config.hideToolBar)
            Toggle("Large", isOn: $settings.large)
            HStack {
                IconLabel("Background", "COLOR")
                ColorPicker("", selection: $background)
                    .onChange(of: background) { value in settings.config.background = Colour(value) }
            }
            HStack {
                IconLabel("Square Color", "COLOR")
                ColorPicker("", selection: $squareColor)
                    .onChange(of: squareColor) { value in settings.squareColor = Colour(value) }
            }
            Section {
                NavigationLink(destination: SettingsAdvancedView(), isActive: $anotherSettingsView) {
                    Label("Advanced Settings", systemImage: "gearshape.2")
                }
            }
        }
        .navigationTitle("Settings")
        .onAppear {
            self.ignoreSafeArea = settings.config.ignoreSafeArea
            self.hideToolBar = settings.config.hideToolBar
            self.hideStatusBar = settings.config.hideStatusBar
            self.background = settings.config.background.color
            self.squareColor = settings.squareColor.color
        }
        .onDisappear {
            if (!self.anotherSettingsView) {
                self.settings.config.updateSettings()
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

private extension ImageContentView.Config {
    var backgroundInternal: Color {
        get { Color(self.background) }
        set { self.background = Colour(newValue) }
    }
}
