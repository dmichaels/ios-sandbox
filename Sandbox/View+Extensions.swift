import SwiftUI

extension View {
    @ViewBuilder
    public func safeArea(ignore: Bool) -> some View {
        if (ignore) { self.ignoresSafeArea() } else { self }
    }
}
