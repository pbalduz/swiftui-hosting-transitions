import Foundation
import SwiftUI

open class MatchedHostingController<Content: View>: UIHostingController<MatchedContainerView<Content>> {
    private let state: MatchedGeometryState
    private lazy var transitionManager = TransitionManager(state: state)

    public init(
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

    @MainActor required dynamic public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.delegate = transitionManager
    }
}
