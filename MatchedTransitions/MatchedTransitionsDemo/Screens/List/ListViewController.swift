//
//  ListViewController.swift
//  MatchedTransitions
//
//  Created by Igor Kharytaniuk on 21.07.24.
//

import UIKit

final class ListViewController: MatchedHostingController<ListScreen> {
    let state = MatchedGeometryState()
  
    init() {
        super.init(
            rootView: ListScreen(),
            state: state
        )
    }
    
    @MainActor required dynamic public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
