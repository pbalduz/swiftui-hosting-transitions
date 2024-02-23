import SwiftUI

struct MatchedGeometryFrameKey: PreferenceKey {
    static let defaultValue: CGRect? = nil
    static func reduce(value: inout CGRect?, nextValue: () -> CGRect?) {
        value = nextValue()
    }
}

struct MatchedGeometryModifier<V: View>: ViewModifier {
    let id: AnyHashable
    let view: V
    let isSource: Bool

    @EnvironmentObject var state: MatchedGeometryState

    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { proxy in
                    Color.clear
                        .preference(
                            key: MatchedGeometryFrameKey.self,
                            value: proxy.frame(in: .global)
                        )
                        .onPreferenceChange(MatchedGeometryFrameKey.self) { newValue in
                            if let newValue {
                                if isSource {
                                    state.sources[id] = (AnyView(view), newValue)
                                } else {
                                    state.destinations[id] = (AnyView(view), newValue)
                                }
                            }
                        }
                }
            )
            .opacity(state.animating ? 0 : 1)
    }
}

extension View {
    public func matchedGeometry<Id: Hashable>(id: Id, isSource: Bool) -> some View {
        modifier(
            MatchedGeometryModifier(
                id: AnyHashable(id),
                view: self,
                isSource: isSource
            )
        )
    }
}
