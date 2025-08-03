import SwiftUI

public class Settings: ObservableObject {
    @Published public var ignoreSafeArea: Bool = false
    @Published public var hideStatusBar: Bool = false
    @Published internal var version: Int = 0
}
