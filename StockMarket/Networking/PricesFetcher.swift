//
//  PricesFetcher.swift
//  StockMarket
//
//  Created by Александр Казак-Казакевич on 20.07.2022.
//

import Foundation

/// A class used for fetching prices of stocks of a certain company (intradays).
final class PricesFetcher: DataFetcher {
    
    /// The instance of `PricesFetcher` shared by all users.
    static var shared = PricesFetcher()
    
    private override init() {
        super.init()
    }
    
    /// Fetches intraday prices for the certain company on the market.
    /// - Returns: A `TradingDay` instance containing current, low, high prices and so on.
    /// - Parameter ticker: A symbol of the company.
    func fetchPrices(for ticker: String) async throws -> TradingDay {
        
        // Complete the URL
        components.path = "/api/v1/quote"
        let symbolItem = URLQueryItem(name: "symbol", value: ticker)
        let keyItem = URLQueryItem(name: "token", value: apiKey)
        components.queryItems = [symbolItem, keyItem]
        
        // Throw an error if the URL is invalid
        guard let url = components.url else {
            throw DataFetchingError.invalidURL
        }
        
        // Make the request
        let request = URLRequest(url: url)
        let (data, _) = try await URLSession.shared.data(for: request)
        
        // Decode the result
        let day = try JSONDecoder().decode(TradingDay.self, from: data)
        
        return day
        
    }
}
