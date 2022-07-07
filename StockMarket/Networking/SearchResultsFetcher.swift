//
//  SearchResultsFetcher.swift
//  StockMarket
//
//  Created by Александр Казак-Казакевич on 06.07.2022.
//

import Foundation

class SearchResultsFetcher: DataFetcher {
    
    static var shared = SearchResultsFetcher()
    
    override private init() {
        super.init()
    }
    
    func fetchResults(for query: String) async throws -> [String] {
        components.path = "/api/v1/search"
        let queryItem = URLQueryItem(name: "q", value: query)
        let keyItem = URLQueryItem(name: "token", value: apiKey)
        components.queryItems = [queryItem, keyItem]
        
        guard let url = components.url else {
            throw DataFetchingError.invalidURL
        }
        
        let request = URLRequest(url: url)
        let (data, _) = try await URLSession.shared.data(for: request)
        let received = try JSONDecoder().decode(SearchResults.self, from: data)
        
        // TODO: Remove debug print statement
        print(received)
        
        return received.results.map { $0.ticker }
    }
    
}

struct SearchResult: Decodable {
    enum CodingKeys: String, CodingKey {
        case description
        case ticker = "displaySymbol"
    }
    
    var description: String
    var ticker: String
}

struct SearchResults: Decodable {
    enum CodingKeys: String, CodingKey {
        case results = "result"
    }
    var results: [SearchResult]
}