//
//  Item.swift
//  MovieApp-Team8-M
//
//  Created by Deemah Alhazmi on 23/12/2025.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
