//
//  PricesFetcher.swift
//  StockMarket
//
//  Created by Александр Казак-Казакевич on 20.07.2022.
//

import Foundation

class PricesFetcher: DataFetcher {
    static var shared = PricesFetcher()
    
    private override init() {
        super.init()
    }
    
    func fetchPrices(for ticker: String) async throws -> TradingDay {
        components.path = "/api/v1/quote"
        let symbolItem = URLQueryItem(name: "symbol", value: ticker)
        let keyItem = URLQueryItem(name: "token", value: apiKey)
        components.queryItems = [symbolItem, keyItem]
        
        guard let url = components.url else {
            throw DataFetchingError.invalidURL
        }
        
        let request = URLRequest(url: url)
        let (data, _) = try await URLSession.shared.data(for: request)
        
        let day = try JSONDecoder().decode(TradingDay.self, from: data)
        
        // TODO: Remove print debug statement
        print(day)
        
        return day
        
    }
}
