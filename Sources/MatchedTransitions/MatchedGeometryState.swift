import SwiftUI

typealias MatchedGeometryValues = [AnyHashable: (AnyView, CGRect)]

public class MatchedGeometryState: ObservableObject {
    @Published private(set) var animating: Bool = false

    @Published private(set) var currentFrames: [AnyHashable: CGRect] = [:]

    @Published var destinations: MatchedGeometryValues = [:]
    var sources: MatchedGeometryValues = [:]

    let animationDuration: TimeInterval

    var sourcesArray: [(id: AnyHashable, view: AnyView, frame: CGRect)] {
        sources
            .filter { source in
                destinations.keys.contains(where: { source.key  == $0 })
            }
            .map { (id: $0.key, view: $0.value.0, frame: $0.value.1) }
    }

    public init(animationDuration: TimeInterval = 0.6) {
        self.animationDuration = animationDuration
    }

    func startPresentation() {
        currentFrames = sources.mapValues(\.1)
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.animating = true
            self.currentFrames = self.destinations.mapValues(\.1)
        }
    }

    func startDismissal() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.animating = true
            self.currentFrames = self.sources.mapValues(\.1)
        }
    }

    func stopAnimation() {
        self.animating = false
    }

    func clearState() {
        self.destinations = [:]
    }
}
