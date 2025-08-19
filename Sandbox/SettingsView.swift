import SwiftUI
import Utils

public struct SettingsView: ImageContentView.SettingsViewable {

    @ObservedObject internal var settings: Settings
    @State          private  var cellSizeDisplay: Int? = nil
    @State          private  var anotherSettingsView: Bool = false

    public var body: some View {
        Form {
            Text("Settings ...")
            Toggle("Ignore Safe Area", isOn: $settings.contentView.ignoreSafeArea)
            Toggle("Hide Status Bar", isOn: $settings.contentView.hideStatusBar)
            Toggle("Hide Tool Bar", isOn: $settings.contentView.hideToolBar)
            HStack {
                IconLabel("Background", "COLOR")
                ColorPicker("", selection: $settings.contentView.background.picker)
            }
            HStack {
                IconLabel("Cell Color", "COLOR")
                ColorPicker("", selection: $settings.cellColor.picker)
            }
            VStack {
                HStack {
                    IconLabel("Cell Size", "magnifyingglass")
                    Text("\(cellSizeDisplay ?? settings.cellSize)").foregroundColor(.secondary)
                }.padding(.bottom, 4)
                Slider(
                    value: Binding(get: { Double(settings.cellSize) }, set: { settings.cellSize = Int($0.rounded()) }),
                                   in: 1...Double(settings.imageView.cellSizeMax), step: 1)
                    .padding(.top, -8).padding(.bottom, -2)
                    .onChange(of: settings.cellSize) { value in
                        cellSizeDisplay = settings.cellSize
                    }
            }
            Toggle("Pixel Scaling", isOn: $settings.scaling)
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
                settings.contentView.applySettings()
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
