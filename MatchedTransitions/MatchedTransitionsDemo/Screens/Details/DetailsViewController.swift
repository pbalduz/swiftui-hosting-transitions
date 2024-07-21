//
//  DetailsViewController.swift
//  MatchedTransitions
//
//  Created by Igor Kharytaniuk on 21.07.24.
//

import UIKit

final class DetailsViewController: MatchedHostingController<DetailsScreen> {
    init(book: Book, state: MatchedGeometryState) {
        super.init(
            rootView: DetailsScreen(book: book),
            state: state
        )
    }
    
    @MainActor required dynamic public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
