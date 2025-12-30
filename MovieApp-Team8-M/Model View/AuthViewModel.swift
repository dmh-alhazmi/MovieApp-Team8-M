//
//  AuthViewModel.swift
//  MovieApp-Team8-M
//
//  Created by Deemah Alhazmi on 30/12/2025.
//


//
//  AuthViewModel.swift
//  MovieApp-Team8-M
//
//  Created by Deemah Alhazmi on 29/12/2025.
//

import SwiftUI
import Combine

@MainActor
final class AuthViewModel: ObservableObject {
    @Published var isSignedIn: Bool = false
    @Published var currentUser: UserRecord?

    func signOut() {
        isSignedIn = false
        currentUser = nil
    }

    func setSignedIn(user: UserRecord) {
        currentUser = user
        isSignedIn = true
    }
}
