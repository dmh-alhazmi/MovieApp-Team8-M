//
//  MovieFields.swift
//  MovieApp-Team8-M
//
//  Created by Deemah Alhazmi on 30/12/2025.
//


//
//  MovieDTO.swift
//  MovieApp-Team8-M
//
//  Created by Deemah Alhazmi on 25/12/2025.
//

import Foundation
import Foundation

struct MovieFields: Decodable {
    let title: String?
    let rating: Double?
    let duration: String?
    let genre: String?
    let poster: [AirtableAttachment]?
}

struct AirtableAttachment: Decodable {
    let url: String
}
