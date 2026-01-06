# 🎬 Movieisme

Movieisme is a sleek, dark-mode movie discovery app designed to help users explore, rate, and save their favorite movies in a clean and immersive experience. The app focuses on simplicity, visual storytelling, and ease of navigation, inspired by modern streaming platforms.

---

## ✨ Features

### 🔐 Authentication
- Sign in using email and password  
- Simple and focused onboarding experience  

### 🎥 Movies Center
- Browse **high-rated movies**
- Explore movies by **genre** (Drama, Comedy, etc.)
- Search for movies by name or actors
- Smooth horizontal scrolling movie lists

### 📄 Movie Details
- Large movie poster header
- Movie information:
  - Duration
  - Language
  - Genre
  - Age rating
- Story / synopsis
- IMDb rating
- Director and cast preview
- User ratings and reviews

### ⭐ Ratings & Reviews
- View overall rating score
- Read user reviews
- Clean card-based review layout

### 👤 Profile
- View user information
- Access saved movies
- Minimal and user-friendly profile design

---

## 🔁 CRUD Operations & API Integration

Movieisme integrates a RESTful API to manage movie data and user interactions. The app follows a clean **MVVM architecture**, separating networking logic from UI logic for better maintainability.

### 📡 API Integration
- Movie data is fetched from a remote API using secure HTTP requests.
- API calls are handled in a dedicated service layer.
- JSON responses are decoded into Swift models using `Codable`.
- All network operations are performed asynchronously to ensure smooth UI performance.

### 🧩 CRUD Operations

- **Create**
  - Users can add ratings and reviews for movies.
  - Users can save movies to their profile.

- **Read**
  - Fetch and display movie lists (popular, high-rated, genre-based).
  - Retrieve detailed movie information including cast, ratings, and reviews.
  - Load user profile data and saved movies.

- **Update**
  - Users can update their ratings or reviews.
  - Profile information can be updated.

- **Delete**
  - Users can remove saved movies from their profile.
  - Users can delete or replace their reviews.

---

### 🧪 Extra Development Practices

- **MVVM Architecture**
  - ViewModels handle business logic and API communication.
  - Views remain lightweight and UI-focused.

- **Reusable Components**
  - Shared UI components (movie cards, rating views) for consistency.

- **Error Handling**
  - Graceful handling of API failures and empty states.

*(Unit testing can be added in future iterations.)*

---

## 🎨 Design & UI

- Dark mode first design 🌙
- High-contrast typography for readability
- Movie-poster-focused layout
- Smooth transitions and spacing
- Minimal UI to keep focus on content

---

## 🛠️ Tech Stack

- **Platform:** iOS  
- **Framework:** SwiftUI  
- **Architecture:** MVVM  
- **Language:** Swift  
- **UI Style:** Dark mode, modern, minimal  

---

## 📱 Screens Included

- Sign In Screen  
- Movies Center (Home)  
- Movie Details Screen  
- Profile Screen  

---

## 🚀 Future Improvements

- Favorites & watchlist sync
- Advanced filters (year, rating, language)
- Trailer playback
- Social features (share reviews)
- Cloud sync for user data
- Unit testing for ViewModels and API services

---

## 👩‍💻 Development Team

Developed by **Team 8**

- **Deemah Alhazmi**
- **Teif Almaneea**
- **Aljowhara Saad bin Samih**

This project focuses on clean UI design, SwiftUI best practices, and delivering an enjoyable movie-browsing experience.

---

## ☕ Notes

This app is a personal/learning project created to practice UI/UX design and SwiftUI development.

---

✨ *Movieisme — Discover movies, beautifully.*
