import SwiftUI

public struct ToolbarView: ToolbarContent {
    private let config: ContentView.Config
    public init(_ config: ContentView.Config) { self.config = config }
    public var body: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Text("Home").font(.headline)
        }
        ToolbarItem(placement: .navigationBarTrailing) {
            Button {
                self.config.showSettingsView()
            } label: {
                Image(systemName: "gearshape")
            }
        }
    }
}
