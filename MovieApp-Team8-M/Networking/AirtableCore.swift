//
//  AirtableCore.swift
//  MovieApp-Team8-M
//
//  Created by Deemah Alhazmi on 30/12/2025.
//

import Foundation

struct AirtableResponse<T: Decodable>: Decodable {
    let records: [AirtableRecord<T>]
}

struct AirtableRecord<T: Decodable>: Decodable {
    let id: String
    let createdTime: String?
    let fields: T
}
