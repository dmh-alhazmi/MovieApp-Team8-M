//
//  UsersService.swift
//  MovieApp-Team8-M
//
//  Created by Deemah Alhazmi on 30/12/2025.
//


//
//  UsersService.swift
//  MovieApp-Team8-M
//
//  Created by Deemah Alhazmi on 29/12/2025.
//

import Foundation

struct UsersService {

    static func fetchUsers() async throws -> [UserRecord] {
        let response: AirtableResponse<UserAirtableFields> = try await APIClient.get(table: "users")
        return response.records
    }

    static func signIn(email: String, password: String) async throws -> UserRecord? {
        let users = try await fetchUsers()

        let normalizedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        let normalizedPassword = password.trimmingCharacters(in: .whitespacesAndNewlines)

        return users.first(where: { record in
            (record.fields.email ?? "").lowercased() == normalizedEmail &&
            (record.fields.password ?? "") == normalizedPassword
        })
    }
}
