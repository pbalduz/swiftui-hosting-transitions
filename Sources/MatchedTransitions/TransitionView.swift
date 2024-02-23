import SwiftUI

struct TransitionView: View {
    @ObservedObject var state: MatchedGeometryState

    var body: some View {
        ZStack {
            ForEach(state.sourcesArray, id: \.id) { (id, source, _) in
                let frame = state.currentFrames[id]!
                let destination = state.destinations[id]!.0
                ZStack {
                    source
                    destination
                }
                .frame(width: frame.width, height: frame.height)
                .position(x: frame.midX, y: frame.midY)
                .ignoresSafeArea()
                .animation(.easeInOut(duration: state.animationDuration), value: frame)
            }
        }
    }
}
