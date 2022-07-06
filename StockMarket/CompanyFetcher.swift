//
//  CompanyFetcher.swift
//  StockMarket
//
//  Created by Александр Казак-Казакевич on 06.07.2022.
//

import Foundation

class CompanyFetcher {
    
    enum CompanyFetchingError: Error {
        case invalidURL
    }
    
    var apiKey: String
    
    static var shared = CompanyFetcher()
    
    private init() {
        guard let keyURL = Bundle.main.url(forResource: "key", withExtension: "txt"), let key = try? String(contentsOf: keyURL) else {
            fatalError()
        }
        apiKey = key.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func fetchCompany(with ticker: String) async throws -> Company {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "finnhub.io"
        components.path = "/api/v1/stock/profile2"
        let symbolItem = URLQueryItem(name: "symbol", value: ticker)
        let keyItem = URLQueryItem(name: "token", value: apiKey)
        components.queryItems = [symbolItem, keyItem]
        
        guard let url = components.url else {
            throw CompanyFetchingError.invalidURL
        }
        
        let request = URLRequest(url: url)
        let (data, _) = try await URLSession.shared.data(for: request)
        let company = try JSONDecoder().decode(Company.self, from: data)
        
        return company
    }
}
