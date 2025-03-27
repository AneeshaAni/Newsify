//
//  NewsResponse.swift
//  Newsify
//
//  Created by Aneesha on 26/03/25.
//

//import Foundation

//// MARK: - Welcome
//struct NewsResponse {
//    let status: String
//    let totalResults: Int
//    let articles: [Article]
//}
//
//// MARK: - Article
//struct Article {
//    let source: Source
//    let author: String?
//    let title: String
//    let description: String?
//    let url: String
//    let urlToImage: String?
//    let publishedAt: Date
//    let content: String
//}
//
//// MARK: - Source
//struct Source {
//    let id: String?
//    let name: String
//}


import Foundation

struct NewsResponse: Codable {
    let articles: [Article]
}

//struct Article: Codable, Identifiable {
//    var id = UUID()
//    let title: String
//    let description: String?
//    let url: String
//    let urlToImage: String?
//}
struct Article: Codable, Identifiable {
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    
    var id = UUID()
    
    private enum CodingKeys: String, CodingKey {
        case title, description, url, urlToImage
    }
}


