//
//  APIError.swift
//  MovieApp-Team8-M
//
//  Created by Deemah Alhazmi on 30/12/2025.
//


//
//  APIClient.swift
//  MovieApp-Team8-M
//
//  Created by Deemah Alhazmi on 25/12/2025.
//

import Foundation

enum APIError: LocalizedError {
    case missingToken
    case badStatus(Int, body: String)

    var errorDescription: String? {
        switch self {
        case .missingToken:
            return "Missing Airtable token."
        case .badStatus(let code, let body):
            return "Request failed (\(code)). \(body)"
        }
    }
}

struct APIClient {

    static func get<T: Decodable>(
        table: String,
        queryItems: [URLQueryItem] = []
    ) async throws -> AirtableResponse<T> {

        guard !APIConfig.token.isEmpty else { throw APIError.missingToken }

        var components = URLComponents(url: APIConfig.baseURL.appendingPathComponent(table),
                                       resolvingAgainstBaseURL: false)!
        if !queryItems.isEmpty { components.queryItems = queryItems }

        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.setValue(APIConfig.authHeader, forHTTPHeaderField: "Authorization")

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let http = response as? HTTPURLResponse else { throw URLError(.badServerResponse) }

        guard (200..<300).contains(http.statusCode) else {
            let body = String(data: data, encoding: .utf8) ?? ""
            throw APIError.badStatus(http.statusCode, body: body)
        }

        let decoder = JSONDecoder()
        return try decoder.decode(AirtableResponse<T>.self, from: data)
    }
}
