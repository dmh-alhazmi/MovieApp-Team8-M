//
//  ContentView.swift
//  MovieApp-Team8-M
//
//  Created by Deemah Alhazmi on 23/12/2025.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    
    var body: some View {
        MoviesCenter()
    }
}
