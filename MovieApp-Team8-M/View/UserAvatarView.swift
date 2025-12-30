//
//  UserAvatarView.swift
//  MovieApp-Team8-M
//
//  Created by Deemah Alhazmi on 30/12/2025.
//


//
//  UserAvatarView.swift
//  MovieApp-Team8-M
//
//  Created by Deemah Alhazmi on 29/12/2025.
//

import Foundation
import SwiftUI

struct UserAvatarView: View {
    let imageURL: String?

    var body: some View {
        Group {
            if let imageURL,
               let url = URL(string: imageURL) {

                AsyncImage(url: url) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                    default:
                        placeholder
                    }
                }

            } else {
                placeholder
            }
        }
        .frame(width: 32, height: 32)
        .clipShape(Circle())
    }

    private var placeholder: some View {
        ZStack {
            Circle()
            Image(systemName: "person.fill")
        }
    }
}
