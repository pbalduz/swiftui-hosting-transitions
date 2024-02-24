import SwiftUI
import UIKit

class TransitionManager: NSObject, UIViewControllerAnimatedTransitioning {
    let state: MatchedGeometryState

    private var operation = UINavigationController.Operation.push

    init(state: MatchedGeometryState) {
        self.state = state
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval { state.animationDuration }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        switch operation {
        case .push:
            guard
                let fromViewController = transitionContext.viewController(forKey: .from),
                let toViewController = transitionContext.viewController(forKey: .to)
            else { return }
            push(toViewController, from: fromViewController, using: transitionContext)

        case .pop:
            guard
                let fromViewController = transitionContext.viewController(forKey: .from),
                let toViewController = transitionContext.viewController(forKey: .to)
            else { return }
            pop(fromViewController, to: toViewController, using: transitionContext)

        default:
            break
        }
    }

    func push(
        _ toViewController: UIViewController,
        from fromViewController: UIViewController,
        using transitionContext: UIViewControllerContextTransitioning
    ) {
        let containerView = transitionContext.containerView

        let transitionViewController = UIHostingController(
            rootView: TransitionView(state: state)
        )

        let cancellable = state.$destinations
            .dropFirst()
            .filter { [weak self] destinations in
                guard let self else { return false }
                return destinations.allSatisfy { destination in
                    self.state.sources.keys.contains(destination.key)
                }
            }
            .sink { [weak self] destinations in
                self?.state.startPresentation()
                containerView.addSubview(transitionViewController.view)
                transitionViewController.view.frame = containerView.bounds
                transitionViewController.view.backgroundColor = .clear
                transitionViewController.view.alpha = 1
            }

        containerView.addSubview(toViewController.view)
        toViewController.view.alpha = 0

        let animator = UIViewPropertyAnimator(duration: state.animationDuration, curve: .easeInOut)
        animator.addCompletion { [weak self] position in
            cancellable.cancel()
            self?.state.stopAnimation()
            transitionViewController.view.removeFromSuperview()
            transitionContext.completeTransition(true)
        }
        animator.addAnimations {
            toViewController.view.alpha = 1
        }
        animator.startAnimation()
    }

    func pop(
        _ fromViewController: UIViewController,
        to toViewController: UIViewController,
        using transitionContext: UIViewControllerContextTransitioning
    ) {
        let containerView = transitionContext.containerView

        containerView.addSubview(toViewController.view)
        toViewController.view.alpha = 0

        let transitionViewController = UIHostingController(
            rootView: TransitionView(state: state)
        )
        containerView.addSubview(transitionViewController.view)
        transitionViewController.view.frame = containerView.bounds
        transitionViewController.view.backgroundColor = .clear
        transitionViewController.view.alpha = 1

        state.startDismissal()

        let animator = UIViewPropertyAnimator(duration: state.animationDuration, curve: .easeInOut)
        animator.addCompletion { [weak self] position in
            self?.state.stopAnimation()
            self?.state.clearState()
            transitionViewController.view.removeFromSuperview()
            transitionContext.completeTransition(position == .end)
        }
        animator.addAnimations {
            toViewController.view.alpha = 1
        }
        animator.startAnimation()
    }
}

extension TransitionManager: UINavigationControllerDelegate {
    func navigationController(
        _ navigationController: UINavigationController,
        animationControllerFor operation: UINavigationController.Operation,
        from fromVC: UIViewController,
        to toVC: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        self.operation = operation
        return self
    }
}
