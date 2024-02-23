import SwiftUI

public struct MatchedContainerView<Content: View>: View {
    let content: Content
    let state: MatchedGeometryState

    public var body: some View {
        content
            .environmentObject(state)
    }
}
