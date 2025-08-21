import SwiftUI
import Utils

public let Display: DisplayInfo = DisplayInfo(size: UIScreen.main.bounds.size, scale: UIScreen.main.scale)
public let Scale: (Int, Bool) -> Int = Display.scale
