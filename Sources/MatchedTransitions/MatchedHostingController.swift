import Foundation
import SwiftUI

public class MatchedHostingController<Content: View>: UIHostingController<MatchedContainerView<Content>> {
    private let state: MatchedGeometryState
    private lazy var transitionManager = TransitionManager(state: state)

    init(
        rootView: Content,
        state: MatchedGeometryState
    ) {
        self.state = state
        super.init(
            rootView: .init(
                content: rootView,
                state: state
            )
        )
    }

    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.delegate = transitionManager
    }
}
