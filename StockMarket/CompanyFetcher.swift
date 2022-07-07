//
//  CompanyFetcher.swift
//  StockMarket
//
//  Created by Александр Казак-Казакевич on 06.07.2022.
//

import Foundation

class CompanyFetcher: DataFetcher {
    
    static var shared = CompanyFetcher()
    
    override private init() {
        super.init()
    }
    
    func fetchCompany(with ticker: String) async throws -> Company {
        components.path = "/api/v1/stock/profile2"
        let symbolItem = URLQueryItem(name: "symbol", value: ticker)
        let keyItem = URLQueryItem(name: "token", value: apiKey)
        components.queryItems = [symbolItem, keyItem]
        
        guard let url = components.url else {
            throw DataFetchingError.invalidURL
        }
        
        let request = URLRequest(url: url)
        let (data, _) = try await URLSession.shared.data(for: request)
        
        // TODO: Remove debug print statements
        print(String(data: data, encoding: .utf8)!)
        let company = try JSONDecoder().decode(Company.self, from: data)
        print(company)
        
        return company
    }
}
