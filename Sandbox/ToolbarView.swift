import SwiftUI

struct ToolbarView: ToolbarContent {
    @Binding var showSettingsView: Bool
    var body: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Text("Home").font(.headline)
        }
        ToolbarItem(placement: .navigationBarTrailing) {
            Button {
                showSettingsView = true
                print("BUTTON!")
            } label: {
                Image(systemName: "gearshape")
            }
        }
    }
}
