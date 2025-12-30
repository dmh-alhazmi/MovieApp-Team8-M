
//  UserDTO.swift
//  MovieApp-Team8-M
//
//  Created by Deemah Alhazmi on 29/12/2025.
//

import Foundation


struct UserAirtableFields: Codable, Hashable {
    let email: String?
    let password: String?
    let name: String?
    let profileImage: String?

    enum CodingKeys: String, CodingKey {
        case email
        case password
        case name
        case profileImage = "profile_image"
    }
}

// ✅ Use your existing AirtableRecord from the project (do NOT redeclare it)
typealias UserRecord = AirtableRecord<UserAirtableFields>
