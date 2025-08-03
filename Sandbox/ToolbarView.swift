import SwiftUI

struct ToolbarView: ToolbarContent {
    let showSettingsView: Binding<Bool>

    var body: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Text("Home").font(.headline)
        }
        ToolbarItem(placement: .navigationBarTrailing) {
            Button {
                showSettingsView.wrappedValue = true
            } label: {
                Image(systemName: "gearshape")
            }
        }
    }
}
