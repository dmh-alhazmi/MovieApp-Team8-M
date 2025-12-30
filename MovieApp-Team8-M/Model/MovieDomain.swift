//
//  Movie.swift
//  MovieApp-Team8-M
//
//  Created by Deemah Alhazmi on 30/12/2025.
//


//
//  MovieDomain.swift
//  MovieApp-Team8-M
//
//  Created by Deemah Alhazmi on 29/12/2025.
//

import Foundation
import Foundation

struct Movie: Identifiable, Hashable {
    enum Category: Hashable {
        case highRated, drama, comedy, other
    }

    let id: String                 // Airtable record id
    let title: String
    let subtitle: String
    let ratingValue: Double        // numeric for stars (0...5)
    let posterURL: URL?
    let story: String
    let runtime: String
    let genre: [String]
    let ageRating: String
    let language: [String]

    // local fallback if you still want to show asset images when URL missing
    let assetImageName: String

    var category: Category {
        let g = (genre.first ?? "").lowercased()
        if g.contains("drama") { return .drama }
        if g.contains("comedy") { return .comedy }
        return .other
    }

    init(record: AirtableRecord<ATMovieFields>) {
        self.id = record.id

        let f = record.fields
        self.title = f.name ?? "Unknown"
        self.posterURL = URL(string: f.poster ?? "")
        self.story = f.story ?? ""
        self.runtime = f.runtime ?? ""
        self.genre = f.genre ?? []
        self.ageRating = f.rating ?? ""
        self.language = f.language ?? []

        // IMDb in your API is like 9.4 (out of 10). Convert to 0...5 for stars.
        let imdb = f.imdbRating ?? 0
        self.ratingValue = max(0, min(5, imdb / 2))

        // Subtitle like your UI
        let gText = self.genre.first ?? "Movie"
        self.subtitle = "\(gText), \(self.runtime)"

        // Keep your old assets as fallback
        self.assetImageName = "MoviesPoster1"
    }
}
