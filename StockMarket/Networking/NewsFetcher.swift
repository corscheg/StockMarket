//
//  NewsFetcher.swift
//  StockMarket
//
//  Created by Александр Казак-Казакевич on 22.07.2022.
//

import Foundation

/// A class that is used for fetching news from server.
final class NewsFetcher: DataFetcher {
    
    /// The`NewsFetcher` instance shared by all users.
    static var shared = NewsFetcher()
    
    private override init() {
        super.init()
    }
    
    /// Fetch latest news.
    /// - Parameter ticker: A ticker of the company you want to fetch news about. Don't provide it if you want general news.
    func fetchNews(about ticker: String? = nil) async throws -> [News] {
        if ticker != nil {
            throw DataFetchingError.invalidURL
        } else {
            // Complete the url
            components.path = "/news"
            let keyItem = URLQueryItem(name: "token", value: apiKey)
            components.queryItems = [keyItem]
        }
        
        // Throw an error if the URL is invalid
        guard let url = components.url else {
            throw DataFetchingError.invalidURL
        }
        
        // Make the request
        let request = URLRequest(url: url)
        let (data, _) = try await URLSession.shared.data(for: request)
        
        // Decode the result
        let news = try JSONDecoder().decode([News].self, from: data)
        
        return news
    }
}
