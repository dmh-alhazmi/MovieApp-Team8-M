//
//  MoviesCenter.swift
//  MovieApp-Team8-M
//
//  Created by Deemah Alhazmi on 23/12/2025.
//

import SwiftUI

// MARK: - MoviesCenter

struct MoviesCenter: View {
    @State private var query = ""
    @State private var selectedMovie: Movie?   // ✅ navigation target
    @State private var showProfile = false     // ✅ push Profile

    private let movies = Movie.sample

    var body: some View {
        NavigationStack {
            ZStack {
                Color(.dark1).ignoresSafeArea()

                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 18) {

                        if isSearching {
                            SectionTitle("Results")
                            SearchResultsGrid(items: searchResults) { movie in
                                selectedMovie = movie
                            }
                        } else {
                            SectionTitle("High Rated")
                            HighRatedCarousel(items: filtered(.highRated)) { movie in
                                selectedMovie = movie
                            }

                            GenreRow(title: "Drama", actionTitle: "Show more", items: filtered(.drama)) { movie in
                                selectedMovie = movie
                            }

                            GenreRow(title: "Comedy", actionTitle: "Show more", items: filtered(.comedy)) { movie in
                                selectedMovie = movie
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 12)
                    .padding(.bottom, 28)
                }
                .searchable(
                    text: $query,
                    placement: .navigationBarDrawer(displayMode: .always),
                    prompt: "Search for Movie name, actors"
                )
            }
            .navigationTitle("Movies Center")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showProfile = true              // ✅ trigger push
                    } label: {
                        Image("ProfileAvatar")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 32, height: 32)
                            .clipShape(Circle())
                    }
                }
            }
            // ✅ Connect to MovieDetailsView
            .navigationDestination(item: $selectedMovie) { _ in
                MovieDetailsView()
            }
            // ✅ Push Profile screen
            .navigationDestination(isPresented: $showProfile) {
                Profile()
            }
        }
        .tint(Color("AccentColor", fallback: .yellow))
    }

    // MARK: - Search logic

    private var isSearching: Bool {
        !query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    private var searchResults: [Movie] {
        let q = query.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        guard !q.isEmpty else { return [] }

        return movies.filter {
            $0.title.lowercased().contains(q) ||
            $0.subtitle.lowercased().contains(q)
        }
    }

    // MARK: - Category filtering (Home sections)

    private func filtered(_ category: Movie.Category) -> [Movie] {
        movies.filter { $0.category == category }
    }
}

// MARK: - Section Title

private struct SectionTitle: View {
    let title: String
    init(_ title: String) { self.title = title }

    var body: some View {
        Text(title)
            .font(.system(size: 22, weight: .bold))
            .foregroundStyle(.white)
            .padding(.top, 6)
    }
}

// MARK: - High Rated Carousel

private struct HighRatedCarousel: View {
    let items: [Movie]
    let onSelect: (Movie) -> Void

    var body: some View {
        TabView {
            ForEach(items) { movie in
                MovieHeroCard(movie: movie, onSelect: onSelect)
                    .padding(.vertical, 6)
                    .padding(.horizontal, 2)
            }
        }
        .frame(height: 360)
        .tabViewStyle(.page(indexDisplayMode: .automatic))
    }
}

private struct MovieHeroCard: View {
    let movie: Movie
    let onSelect: (Movie) -> Void

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image(movie.imageName)
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity)
                .frame(height: 340)
                .clipped()
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))

            LinearGradient(
                colors: [.clear, .black.opacity(0.85)],
                startPoint: .top,
                endPoint: .bottom
            )
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))

            VStack(alignment: .leading, spacing: 6) {
                Text(movie.title)
                    .font(.system(size: 28, weight: .bold))
                    .foregroundStyle(.white)

                StarRatingView(value: movie.rating)
                    .font(.caption)

                Text("\(movie.rating, specifier: "%.1f") out of 5")
                    .foregroundStyle(.white.opacity(0.9))
                    .font(.subheadline)

                Text(movie.subtitle)
                    .foregroundStyle(.white.opacity(0.75))
                    .font(.caption)
            }
            .padding(16)
        }
        .contentShape(Rectangle())
        .onTapGesture { onSelect(movie) }   // ✅ navigate
    }
}

// MARK: - Search Results Grid (only shown during search)

private struct SearchResultsGrid: View {
    let items: [Movie]
    let onSelect: (Movie) -> Void

    private let columns = [
        GridItem(.flexible(), spacing: 14),
        GridItem(.flexible(), spacing: 14)
    ]

    var body: some View {
        if items.isEmpty {
            ContentUnavailableView(
                "No results",
                systemImage: "magnifyingglass",
                description: Text("Try a different name or actor.")
            )
            .tint(.secondary)
            .padding(.top, 24)
        } else {
            LazyVGrid(columns: columns, spacing: 14) {
                ForEach(items) { movie in
                    PosterCard(movie: movie, onSelect: onSelect)
                }
            }
            .padding(.top, 6)
        }
    }
}

// MARK: - Genre Row

private struct GenreRow: View {
    let title: String
    let actionTitle: String
    let items: [Movie]
    let onSelect: (Movie) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(title)
                    .font(.system(size: 26, weight: .bold))
                    .foregroundStyle(.white)

                Spacer()

                Button(actionTitle) {
                    // later: push a grid/list screen
                }
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(Color("AccentColor", fallback: .yellow))
                .buttonStyle(.plain)
            }

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 14) {
                    ForEach(items) { movie in
                        PosterCard(movie: movie, onSelect: onSelect)
                    }
                }
                .padding(.vertical, 4)
            }
        }
        .padding(.top, 8)
    }
}

private struct PosterCard: View {
    let movie: Movie
    let onSelect: (Movie) -> Void

    var body: some View {
        Image(movie.imageName)
            .resizable()
            .scaledToFill()
            .frame(width: 165, height: 240)
            .clipped()
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .stroke(Color.white.opacity(0.08), lineWidth: 1)
            )
            .contentShape(Rectangle())
            .onTapGesture { onSelect(movie) }  // ✅ navigate
    }
}

// MARK: - Stars

private struct StarRatingView: View {
    let value: Double // 0...5

    var body: some View {
        let full = Int(value.rounded(.down))
        let hasHalf = (value - Double(full)) >= 0.5

        HStack(spacing: 2) {
            ForEach(0..<5, id: \.self) { i in
                Image(systemName: starName(index: i, full: full, hasHalf: hasHalf))
                    .foregroundStyle(Color("AccentColor", fallback: .yellow))
            }
        }
        .accessibilityLabel("Rating \(value, specifier: "%.1f") out of 5")
    }

    private func starName(index: Int, full: Int, hasHalf: Bool) -> String {
        if index < full { return "star.fill" }
        if index == full && hasHalf { return "star.leadinghalf.filled" }
        return "star"
    }
}

// MARK: - Model

struct Movie: Identifiable, Hashable {
    enum Category: Hashable {
        case highRated, drama, comedy
    }

    let id = UUID()
    let title: String
    let imageName: String
    let rating: Double
    let subtitle: String
    let category: Category

    static let sample: [Movie] = [
        Movie(title: "Top Gun",
              imageName: "MoviesPoster1",
              rating: 4.8,
              subtitle: "Action, 2 hr 9 min",
              category: .highRated),

        Movie(title: "Shawshank",
              imageName: "DramaMovie1",
              rating: 4.9,
              subtitle: "Drama, 2 hr 22 min",
              category: .drama),

        Movie(title: "A Star Is Born",
              imageName: "DramaMovie2",
              rating: 4.7,
              subtitle: "Drama/Romance, 2 hr 16 min",
              category: .drama),

        Movie(title: "World's Greatest Dad",
              imageName: "CoMovie1",
              rating: 4.2,
              subtitle: "Comedy, 1 hr 39 min",
              category: .comedy),

        Movie(title: "House Party",
              imageName: "CoMovie2",
              rating: 4.0,
              subtitle: "Comedy, 1 hr 40 min",
              category: .comedy)
    ]
}

// MARK: - Safe Color fallback (prevents crash if asset missing)

private extension Color {
    init(_ assetName: String, fallback: Color) {
        if UIColor(named: assetName) != nil {
            self.init(assetName)
        } else {
            self = fallback
        }
    }
}

// MARK: - Preview

#Preview {
    MoviesCenter()
        .preferredColorScheme(.dark)
}
