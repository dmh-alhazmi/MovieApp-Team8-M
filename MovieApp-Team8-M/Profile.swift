//
//  Profile.swift
//  MovieApp-Team8-M
//
//  Created by Teif May on 05/07/1447 AH.
//

import SwiftUI

struct Profile: View {
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack(alignment: .leading, spacing: 24) {
                Button {

                } label: {
                    HStack(spacing: 6) {
                        Image(systemName: "chevron.left")
                        Text("Back")
                    }
                    .font(.body.weight(.semibold))
                    .foregroundStyle(.yellow)
                }
                .buttonStyle(.plain)
                .padding(.top, 8)

                Text("Profile")
                    .font(.system(size: 34, weight: .bold))
                    .foregroundStyle(.white)
                    .padding(2)
                HStack(spacing: 12) {
                    avatar
                        .frame(width: 44, height: 44)
                        .clipShape(Circle())

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Sarah Abdullah")
                            .font(.headline.weight(.semibold))
                            .foregroundStyle(.white)

                        Text("Xxxx234@gmail.com")
                            .font(.subheadline)
                            .foregroundStyle(.white.opacity(0.7))
                    }

                    Spacer()

                    Image(systemName: "chevron.right")
                        .foregroundStyle(.white.opacity(0.6))
                        .font(.system(size: 16, weight: .semibold))
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                        .fill(Color.white.opacity(0.08))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                        .stroke(Color.white.opacity(0.08), lineWidth: 1)
                )

                Text("Saved movies")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundStyle(.white)
                    .padding(.top, 4)

                Spacer()


                VStack{
                    ZStack {
                        Image("No Saved Movies")
                    }
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .padding(.bottom, 60)
            }
            .padding(.horizontal, 16)
            .padding(.top, 8)
        }
    }

    private var avatar: some View {
        Group {
            if UIImage(named: "ProfileAvatar") != nil {
                Image("ProfileAvatar")
                    .resizable()
                    .scaledToFill()
            } else {
                ZStack {
                    Circle().fill(.white.opacity(0.15))
                    Image(systemName: "person.fill")
                        .foregroundStyle(.white.opacity(0.8))
                }
            }
        }
    }
}

#Preview {
    Profile()
}
