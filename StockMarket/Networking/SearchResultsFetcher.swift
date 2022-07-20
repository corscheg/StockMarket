//
//  SearchResultsFetcher.swift
//  StockMarket
//
//  Created by Александр Казак-Казакевич on 06.07.2022.
//

import Foundation

/// A class used for searching companies by a query.
final class SearchResultsFetcher: DataFetcher {
    
    /// A struct used to decode the inner part of the JSON.
    private struct SearchResult: Decodable {
        enum CodingKeys: String, CodingKey {
            case ticker = "displaySymbol"
        }
        var ticker: String
    }

    /// A struct used to decode the outer part of the JSON.
    private struct SearchResults: Decodable {
        enum CodingKeys: String, CodingKey {
            case results = "result"
        }
        var results: [SearchResult]
    }
    
    /// The instance of `SearchResultsFetcher` shared by all users.
    static var shared = SearchResultsFetcher()
    
    override private init() {
        super.init()
    }
    
    /// Fetches a results for certain query. **May work unappropriate with some company names due to unknown reasons coming from the API.**
    /// - Returns: An array of symbols of matching companies.
    /// - Parameter query: A company name or symbol.
    func fetchResults(for query: String) async throws -> [String] {
        
        // Complete the URL
        components.path = "/api/v1/search"
        let queryItem = URLQueryItem(name: "q", value: query)
        let keyItem = URLQueryItem(name: "token", value: apiKey)
        components.queryItems = [queryItem, keyItem]
        
        // Throw an error if the URL is invalid
        guard let url = components.url else {
            throw DataFetchingError.invalidURL
        }
        
        // Make the request
        let request = URLRequest(url: url)
        let (data, _) = try await URLSession.shared.data(for: request)
        
        // Decode the result
        let received = try JSONDecoder().decode(SearchResults.self, from: data)
        
        // Return only tickers
        return received.results.map { $0.ticker }
    }
    
}
