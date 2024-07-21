//
//  DataManager.swift
//  MatchedTransitions
//
//  Created by Igor Kharytaniuk on 20.07.24.
//

import Foundation
import SwiftUI

/// Manager that is responsible for providing data
final class DataManager {
    
    // ******************************* MARK: - Singleton
    
    static let shared = DataManager()
    private init() {}
    
    var imageCache: [String : Image] = [:]
    
    func fetchBooks() async throws -> [Book] {
        let url = URL(string: "https://gutendex.com/books/")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(BooksResponse.self, from: data)
        return response.results
    }
}
