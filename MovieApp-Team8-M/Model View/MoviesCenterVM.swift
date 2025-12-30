//
//  MoviesCenterVM.swift
//  MovieApp-Team8-M
//
//  Created by Deemah Alhazmi on 30/12/2025.
//


//
//  MoviesCenterVM.swift
//  MovieApp-Team8-M
//
//  Created by Deemah Alhazmi on 29/12/2025.
//

import Foundation
import Observation

@MainActor
@Observable
final class MoviesCenterVM {

    var movies: [Movie] = []
    var isLoading: Bool = false
    var errorMessage: String?

    func load() async {
        guard !isLoading else { return }  // ✅ prevents double load
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }

        do {
            let records = try await MovieService.fetchMovies()
            movies = records.map(Movie.init(record:))
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    /// “High Rated”: top 5 by rating
    var highRated: [Movie] {
        Array(movies.sorted { $0.ratingValue > $1.ratingValue }.prefix(5))
    }

    func byCategory(_ c: Movie.Category) -> [Movie] {
        movies.filter { $0.category == c }
    }
}
