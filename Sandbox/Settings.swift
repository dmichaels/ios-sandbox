import SwiftUI

public class Settings: ObservableObject {
    @Published var ignoreSafeArea: Bool = false
    @Published var hideStatusBar: Bool = false
    @Published var version: Int = 0
}
