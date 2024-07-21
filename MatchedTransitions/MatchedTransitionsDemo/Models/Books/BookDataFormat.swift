//
//  BookDataFormat.swift
//  MatchedTransitions
//
//  Created by Igor Kharytaniuk on 20.07.24.
//

import Foundation

struct BookDataformat: Decodable {
    let image: String?

    enum CodingKeys: String, CodingKey {
        case image = "image/jpeg"
    }
}
