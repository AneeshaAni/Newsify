

import SwiftUI

struct SavedListView: View {
    @State private var savedArticles: [SavedArticle] = []
    @State private var selectedArticle: Article?
    @State private var isNavigating = false
    @State private var selectedArticleURL: String? = nil
    
    var body: some View {
        NavigationView {
            VStack {
                if savedArticles.isEmpty {
                    Text("No Saved News")
                        .font(.title3)
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    List(savedArticles, id: \.self) { article in
                        articleRow(article)
                    }
                    .listStyle(PlainListStyle())
                }
                NavigationLink(
                    destination: ArticleWebView(urlString: selectedArticleURL ?? "" ,selectedArticle: selectedArticle),
                    isActive: $isNavigating
                ) {
                    EmptyView()
                }
            }
            .navigationTitle("Saved News")

            .onAppear {
                let fetchedArticles = CoreDataManager.shared.fetchSavedArticles()
                var uniqueArticles: [String: SavedArticle] = [:]
                
                for article in fetchedArticles {
                    if let url = article.url {
                        uniqueArticles[url] = article
                    }
                }
                
                savedArticles = Array(uniqueArticles.values).sorted { $0.title ?? "" < $1.title ?? "" }
            }


        }
    }

    @ViewBuilder
    private func articleRow(_ article: SavedArticle) -> some View {
        HStack(alignment: .top, spacing: 12) {
            articleImage(article.urlToImage)

            VStack(alignment: .leading, spacing: 6) {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 6) {
                        Text(article.title ?? "No Title")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.primary)
                            .padding(.trailing, 10)
                            .padding(.top, 10)
                    }

                    
                    Button(action: {
                        CoreDataManager.shared.deleteArticle(article)
//                        savedArticles = CoreDataManager.shared.fetchSavedArticles()
                        let fetchedArticles = CoreDataManager.shared.fetchSavedArticles()
                        var uniqueArticles: [String: SavedArticle] = [:]
                        
                        for article in fetchedArticles {
                            if let url = article.url {
                                uniqueArticles[url] = article
                            }
                        }
                        
                        savedArticles = Array(uniqueArticles.values).sorted { $0.title ?? "" < $1.title ?? "" }
                    }) {
                        Image(systemName: "trash")
                            .resizable()
                            .foregroundColor(.blue)
                            .frame(width: 20, height: 20)
                            .padding(10)
                    }
                    .buttonStyle(PlainButtonStyle())
                }

                Text(article.des ?? "No Description")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.trailing, 10)
                    .padding(.top, 10)

                HStack {
                    Spacer()
                    Button(action: {
                        print("url --- \(article.url)")
                        selectedArticleURL = article.url
                        selectedArticle = Article(title: article.title ?? "", description: article.des ?? "", url: article.url ?? "", urlToImage: article.urlToImage ?? "")
                        isNavigating = true
                    }) {
                        Text("Read More")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.blue)
                            .padding(.bottom, 10)
                            
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .padding(.horizontal, 10)
                .padding(.top, 10)
            }
        }
        .contentShape(Rectangle())
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.gray, lineWidth: 0.5)
        )
        .padding(.vertical, 8)
        .listRowSeparator(.hidden)
    }


    // MARK: - Separate Image View
    @ViewBuilder
    private func articleImage(_ imageUrl: String?) -> some View {
        if let imageUrl = imageUrl, let url = URL(string: imageUrl) {
            AsyncImage(url: url) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                Color.gray.opacity(0.3)
            }
            .frame(width: 100, height: 80)
            .cornerRadius(8)
            .padding(.leading, 10)
            .padding(.top, 10)
        } else {
            Color.gray.opacity(0.3)
                .frame(width: 100, height: 80)
                .cornerRadius(8)
                .padding(.leading, 10)
                .padding(.top, 10)
        }
    }
}

#Preview {
    SavedListView()
}
