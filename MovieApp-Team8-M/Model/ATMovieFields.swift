
//
//  ATMovieDTO.swift
//  MovieApp-Team8-M
//
//  Created by Deemah Alhazmi on 29/12/2025.
//

import Foundation
import Foundation

struct ATMovieFields: Codable, Hashable {
    let name: String?
    let poster: String?
    let story: String?
    let runtime: String?
    let genre: [String]?
    let rating: String?
    let imdbRating: Double?
    let language: [String]?

    enum CodingKeys: String, CodingKey {
        case name, poster, story, runtime, genre, rating, language
        case imdbRating = "IMDb_rating"   // ✅ based on your screenshot
    }
}
