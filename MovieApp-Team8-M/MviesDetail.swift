//
//  MviesDetail.swift
//  MovieApp-Team8-M
//
//  Created by Jojo on 23/12/2025.
//

import SwiftUI

struct MovieDetailsView: View {
    var body: some View {
        ZStack {
            // الخلفية السوداء الأساسية
            Color.black.ignoresSafeArea()
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {
                    
                    // MARK: - الهيكل الأول: Header & Poster
                    // يحتوي على الصورة، أزرار التحكم، واسم الفيلم
                    HeaderSection()
                    
                    VStack(alignment: .leading, spacing: 25) {
                        
                        // MARK: - الهيكل الثاني: Info Grid
                        // يعرض تفاصيل المدة، النوع، اللغة، والعمر
                        InfoGridView()
                        
                        // MARK: - هيكل القصة: Story
                        StorySection()
                        
                        // MARK: - هيكل الطاقم: Director & Stars
                        // يعرض المخرج والممثلين الثلاثة
                        CastSection()
                        
                        // MARK: - الخط الفاصل
                        // مقاساته حسب طلبك w355 h0
                        Rectangle()
                            .frame(width: 355, height: 1) // الارتفاع 1 ليكون خطاً واضحاً
                            .foregroundColor(.gray.opacity(0.3))
                            .padding(.vertical, 10)
                        
                        // MARK: - الهيكل الرابع: Ratings & Reviews
                        // يشمل التقييم الرقمي وقائمة المراجعات الأفقية
                        RatingsAndReviewsSection()
                    }
                    .padding(.horizontal)
                    .padding(.top, 20)
                }
            }
            .ignoresSafeArea(edges: .top)
        }
    }
}

// MARK: - 1. Header View
struct HeaderSection: View {
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            // صورة الفيلم بالمقاسات المحددة
            Image("movies")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 390, height: 448)
                .clipped()
            
            // التدرج لظهور اسم الفيلم بوضوح
            LinearGradient(gradient: Gradient(colors: [.clear, .black.opacity(0.8)]), startPoint: .center, endPoint: .bottom)
            
            // أزرار البار العلوي
            VStack {
                HStack {
                    Image(systemName: "chevron.left")
                        .padding(10)
                        .background(.ultraThinMaterial)
                        .clipShape(Circle())
                    
                    Spacer()
                    
                    HStack(spacing: 15) {
                        Image(systemName: "square.and.arrow.up")
                        Image(systemName: "bookmark")
                    }
                    .padding(10)
                    .background(.ultraThinMaterial)
                    .clipShape(Capsule())
                }
                .foregroundColor(.white)
                .padding(.top, 60)
                .padding(.horizontal)
                
                Spacer()
            }
            
            // عنوان الفيلم فوق الصورة
            Text("Shawshank")
                .font(.system(size: 35, weight: .bold))
                .foregroundColor(.white)
                .padding(.leading, 20)
                .padding(.bottom, 20)
        }
        .frame(width: 390, height: 448)
    }
}

// MARK: - 2. Info Grid View
struct InfoGridView: View {
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        LazyVGrid(columns: columns, alignment: .leading, spacing: 20) {
            infoItem(title: "Duration", value: "2 hours 22 mins")
            infoItem(title: "Language", value: "English")
            infoItem(title: "Genre", value: "Drama")
            infoItem(title: "Age", value: "+15")
        }
    }
    
    func infoItem(title: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title).font(.system(size: 18, weight: .bold)).foregroundColor(.white)
            Text(value).font(.system(size: 14)).foregroundColor(.gray)
        }
    }
}

// MARK: - 3. Story View
struct StorySection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Story").font(.headline).foregroundColor(.white)
            Text("Synopsis. In 1947, Andy Dufresne (Tim Robbins), a banker in Maine, is convicted of murdering his wife and her lover, a golf pro. Since the state of Maine has no death penalty, he is given two consecutive life sentences and sent to the notoriously harsh Shawshank Prison.")
                .font(.system(size: 14))
                .foregroundColor(.gray)
                .lineSpacing(4)
        }
    }
}

// MARK: - 4. Cast View
struct CastSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Director").font(.headline).foregroundColor(.white)
            castMember(name: "Frank Darabont")
            
            Text("Stars").font(.headline).foregroundColor(.white)
            HStack(spacing: 25) {
                castMember(name: "Tim Robbins")
                castMember(name: "Morgan Freeman")
                castMember(name: "Bob Gunton")
            }
        }
    }
    
    func castMember(name: String) -> some View {
        VStack {
            Image("movies")
                .resizable()
                .scaledToFill()
                .frame(width: 70, height: 70)
                .clipShape(Circle())
            Text(name).font(.system(size: 12)).foregroundColor(.white)
        }
    }
}

// MARK: - 5. Ratings & Reviews View
struct RatingsAndReviewsSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Rating & Reviews").font(.headline).foregroundColor(.white)
            
            VStack(alignment: .leading) {
                Text("4.8").font(.system(size: 45, weight: .bold)).foregroundColor(.white)
                Text("out of 5").font(.caption).foregroundColor(.gray)
                Text("⭐⭐⭐⭐").font(.caption)
            }
            
            // التمرير الأفقي للريفيوز بمقاسات w305 h188
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ReviewCard()
                    ReviewCard()
                    ReviewCard()
                }
            }
            .padding(.bottom, 40)
        }
    }
}

// MARK: - 6. Review Card Component
struct ReviewCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .top) {
                Image("movies")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                
                VStack(alignment: .leading) {
                    Text("Afnan Abdullah").font(.system(size: 14, weight: .bold)).foregroundColor(.white)
                    Text("⭐⭐⭐⭐").font(.system(size: 10))
                }
                Spacer()
            }
            
            Text("This is an engagingly simple, good-hearted film, with just enough darkness around the edges to give contrast and relief to its glowingly benign view of human nature.")
                .font(.system(size: 12))
                .foregroundColor(.gray)
                .lineLimit(4)
            
            Spacer()
            
            HStack {
                Spacer()
                Text("Tuesday").font(.system(size: 10)).foregroundColor(.gray)
            }
        }
        .padding()
        // المقاس المطلوب للكرت
        .frame(width: 305, height: 188)
        .background(Color.white.opacity(0.1))
        .cornerRadius(15)
    }
}

// MARK: - Preview Section
struct MovieDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            // عرض الواجهة في الوضع الليلي للتأكد من تناسق الألوان
            MovieDetailsView()
                .preferredColorScheme(.dark)
                .previewDevice("iPhone 15 Pro")
            
            // يمكنك أيضاً عرض كرت الريفيو منفرداً لتعديله بدقة
            ReviewCard()
                .previewLayout(.sizeThatFits)
                .padding()
                .background(Color.black)
                .preferredColorScheme(.dark)
                .previewDisplayName("Review Card Component")
        }
    }
}
