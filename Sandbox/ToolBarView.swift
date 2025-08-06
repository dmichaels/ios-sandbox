import SwiftUI

public struct ToolBarView: ToolbarContent {
    private let config: ImageContentView.Config
    public init(_ config: ImageContentView.Config) { self.config = config }
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
