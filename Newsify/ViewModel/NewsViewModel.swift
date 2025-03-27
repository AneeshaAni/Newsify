//  NewsViewModel.swift
//  Newsify
//  Created by Aneesha on 26/03/25.

import Foundation

class NewsViewModel: ObservableObject {
    @Published var articles: [Article] = []
    @Published var isLoading: Bool = false
    
    func fetchNews() {
        isLoading = true
        let urlString = "https://newsapi.org/v2/everything?q=apple&from=2025-03-25&to=2025-03-25&sortBy=popularity&apiKey=297d1d1835714d768364ea035ff7313a"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching news: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else { return }
            
            do {
                let newsResponse = try JSONDecoder().decode(NewsResponse.self, from: data)
                DispatchQueue.main.async {
                    print("newsResponse \(newsResponse)")
                    self.articles = newsResponse.articles
                    self.isLoading = false
                    
                }
            } catch {
                print("Decoding error: \(error)")
            }
        }.resume()
    }
}
