//
//  MovieService.swift
//  MovieApp-Team8-M
//
//  Created by Deemah Alhazmi on 30/12/2025.
//


//
//  MovieService.swift
//  MovieApp-Team8-M
//
//  Created by Deemah Alhazmi on 25/12/2025.
//

import Foundation


enum MovieService {
    static func fetchMovies() async throws -> [AirtableRecord<ATMovieFields>] {
        let response: AirtableResponse<ATMovieFields> = try await APIClient.get(table: "movies")
        return response.records
    }
}
