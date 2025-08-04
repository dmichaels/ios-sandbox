import SwiftUI

public class Settings: ObservableObject {
    @Published public var ignoreSafeArea: Bool = true
    @Published public var hideStatusBar: Bool = true
    @Published internal var version: Int = 0
    public static let Defaults: Settings = Settings()
}
