//
//  FavoritesManager.swift
//  StockMarket
//
//  Created by Александр Казак-Казакевич on 11.07.2022.
//

import Foundation

/// A class responsible for storing favorite companies.
class FavoritesManager {
    
    /// Key for storing favorites in UserDefaults.
    private let key = "favorites"
    
    /// An array for favorite companies.
    private(set) var favorites: [Company]
    
    /// The instance of `FavoritesManager` shared by all users.
    public static var shared = FavoritesManager()
    
    private init() {
        
        // Check if field under "favorites" key exists in UserDefaults
        if let data = UserDefaults.standard.data(forKey: key) {
            
            // Check if field content is compatible with [Company] type
            if let companies = try? JSONDecoder().decode([Company].self, from: data) {
                
                // Set the property
                favorites = companies
            } else {
                
                // Crash if content is not compatible
                fatalError("Invalid favorites format!!!")
            }
        } else {
            
            // Field does not exist -- favorites is empty
            favorites = []
        }
    }

    /// Saves current instance of favorites to UserDefaults.
    private func save() {
        if let data = try? JSONEncoder().encode(favorites) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }
    
    /// Adds a company to favorites.
    /// - Parameter company: A company to add.
    func add(_ company: Company) {
        favorites.append(company)
        save()
    }
    
    /// Removes a company from favorites.
    /// - Parameter company: A company to remove. If the company is not present in the favorites, the function does nothing.
    func remove(_ company: Company) {
        
        // Extract tickers
        let tickers = favorites.map { $0.ticker }
        
        // Search by ticker, remove and save
        if let index = tickers.firstIndex(of: company.ticker) {
            favorites.remove(at: index)
            save()
        }
    }
    
    /// Removes all favorite companies.
    func clearAll() {
        favorites = []
        save()
    }
    
    /// Refreshes data about favorites by fetching information from API.
    func refreshData() async {
        
        // Extract tickers
        let tickers = favorites.map { $0.ticker }
        
        var refreshed = [Company]()
        
        // Loop through every ticker
        for i in 0..<tickers.count {
            if let new = try? await CompanyFetcher.shared.fetchCompany(with: tickers[i]) {
                
                // If fetcher successfully returns data, add the refreshed company
                refreshed.append(new)
            } else {
                
                // If not, add an old instance
                refreshed.append(favorites[i])
            }
        }
        
        favorites = refreshed
        save()
    }
    
    /// Checks if a company is present in the favorites.
    /// - Parameter ticker: A symbol of the company.
    func isFavoriteBy(ticker: String) -> Bool {
        
        // Extract tickers
        let tickers = favorites.map { $0.ticker }
        
        // Search by ticker
        if let _ = tickers.firstIndex(of: ticker) {
            return true
        }
        return false
    }
}
