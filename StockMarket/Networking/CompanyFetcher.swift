//
//  CompanyFetcher.swift
//  StockMarket
//
//  Created by Александр Казак-Казакевич on 06.07.2022.
//

import Foundation

/// A class used for fetching information about a certain company.
final class CompanyFetcher: DataFetcher {
    
    /// The instance of `CompanyFetcher` shared by all users.
    static var shared = CompanyFetcher()
    
    override private init() {
        super.init()
    }
    
    /// Fetches a certain company via finnhub API.
    /// - Returns: A `Company` instance with or without logo binary data.
    /// - Parameter ticker: A symbol of the company.
    func fetchCompany(with ticker: String) async throws -> Company {
        
        // Complete the URL
        components.path = "/api/v1/stock/profile2"
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
        var company = try JSONDecoder().decode(Company.self, from: data)
        
        // Return current `company` if logo URL is invalid
        guard let logoURL = company.logoURL else {
            return company
        }
        
        // Fetch and set the `logoImageData` property
        let (imageData, _) = try await URLSession.shared.data(from: logoURL)
        company.logoImageData = imageData
        
        return company
    }
}
