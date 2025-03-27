
import SwiftUI

struct NewsListView: View {
    @StateObject private var viewModel = NewsViewModel()
    @State private var selectedArticleURL: String? = nil
    @State private var selectedArticleUUID = UUID()
    @State private var selectedArticle: Article?
    @State private var isNavigating = false
    @State private var searchText = ""
    @AppStorage("isDarkMode") private var isDarkMode = false
    @Environment(\.colorScheme) private var colorScheme
    
    var filteredArticles: [Article] {
        if searchText.isEmpty {
            return viewModel.articles
        } else {
            return viewModel.articles.filter {
                $0.title.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
             
                if !viewModel.isLoading {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        TextField("Search news...", text: $searchText)
                            .textFieldStyle(PlainTextFieldStyle())
                            .padding(8)
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                    .padding(.top, 10)
                }
                
                ZStack {
                    if viewModel.isLoading {
                        ProgressView("Loading News...")
                            .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                            .scaleEffect(1.5)
                    } else {
                        List(filteredArticles) { article in
                            HStack(alignment: .top, spacing: 12) {
                                if let imageUrl = article.urlToImage, let url = URL(string: imageUrl) {
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
                                
                                VStack(alignment: .leading, spacing: 6) {
                                    Text(article.title)
                                        .font(.system(size: 16, weight: .semibold))
                                        .foregroundColor(.primary)
                                        .padding(.trailing, 10)
                                        .padding(.top, 10)
                                    
                                    Text(article.description ?? "")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                        .padding(.trailing, 10)
                                        .padding(.top, 10)
                                    
                                    HStack {
                                        Spacer()
                                        Button(action: {
                                            selectedArticle = article
                                            selectedArticleURL = article.url
                                            selectedArticleUUID = article.id
                                            isNavigating = true
                                        }) {
                                            Text("Read More")
                                                .font(.system(size: 14, weight: .semibold))
                                                .foregroundColor(.cyan)
                                                .padding(.bottom, 10)
                                        }
                                        .buttonStyle(PlainButtonStyle())
                                    }
                                    .padding(.horizontal, 10)
                                    .padding(.top, 10)
                                }
                            }
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray, lineWidth: 0.5)
                            )
                            .padding(.vertical, 8)
                            .listRowSeparator(.hidden)
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
            }
            .navigationTitle("News")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isDarkMode.toggle()
                    }) {
                        Image(systemName: isDarkMode ? "sun.max.fill" : "moon.fill")
                            .imageScale(.large)
                            .tint(.cyan)
                    }
                }
            }
            .preferredColorScheme(isDarkMode ? .dark : .light)
            .onAppear {
                viewModel.fetchNews()
            }
        }
    }
}
