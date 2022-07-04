//
//  Networking.swift
//  StockMarket
//
//  Created by Александр Казак-Казакевич on 04.07.2022.
//

import Foundation

struct ShareFetcher {
    
    enum FetchingError: Error {
        case invalidURL
    }
    
    var apiKey: String {
        guard let url = Bundle.main.url(forResource: "key", withExtension: "txt"), let key = try? String(contentsOf: url) else {
            fatalError("There is not an API key in the app Bundle!!!")
        }
        return key
    }
    
    func fetchShare(withTicker ticker: String) async throws -> Share {
        // let url = URL(string: "https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=IBM&apikey=demo")!
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "www.alphavantage.co"
        components.path = "/query"
        let function = URLQueryItem(name: "function", value: "TIME_SERIES_DAILY")
        let company = URLQueryItem(name: "symbol", value: ticker)
        let key = URLQueryItem(name: "apikey", value: apiKey)
        components.queryItems = [function, company, key]
        
        guard let url = components.url else {
            throw FetchingError.invalidURL
        }
        
        let request = URLRequest(url: url)
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let decoder = JSONDecoder()
        
        let share = try decoder.decode(Share.self, from: data)
        print(share.ticker)
        print(share.prices)
        
        return share
    }
}
