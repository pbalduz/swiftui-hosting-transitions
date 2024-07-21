//
//  Book.swift
//  MatchedTransitions
//
//  Created by Igor Kharytaniuk on 20.07.24.
//

import Foundation

struct Book: Decodable, Identifiable {
    let id: Int
    let title: String
    let downloads: Int
    let data: BookDataformat

    enum CodingKeys: String, CodingKey {
        case id, title
        case downloads = "download_count"
        case data = "formats"
    }
}
