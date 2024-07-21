//
//  BooksResponse.swift
//  MatchedTransitions
//
//  Created by Igor Kharytaniuk on 20.07.24.
//

import Foundation

struct BooksResponse: Decodable {
    let results: [Book]
}
