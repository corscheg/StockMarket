//
//  FavoritesManager.swift
//  StockMarket
//
//  Created by Александр Казак-Казакевич on 11.07.2022.
//

import Foundation

class FavoritesManager {
    private let key = "favorites"
    
    private(set) var favorites: [Company] = []
    private var favoriteTickers: [String] {
        if let tickers = UserDefaults.standard.object(forKey: key) {
            if let stringTickers = tickers as? [String] {
                return stringTickers
            } else {
                fatalError("Wrong favorites type in UserDefaults!!!")
            }
        } else {
            return []
        }
    }
    
    public static var shared = FavoritesManager()
    
    private func fetchCompanies() {
        favorites = []
        for favoriteTicker in favoriteTickers {
            Task {
                try? await favorites.append(CompanyFetcher.shared.fetchCompany(with: favoriteTicker))
            }
        }
    }
    
    func save(_ ticker: String) {
        UserDefaults.standard.set(favoriteTickers + [ticker], forKey: key)
        fetchCompanies()
    }
    
    func remove(_ ticker: String) {
        var favorites = favoriteTickers
        guard let index = favorites.firstIndex(of: ticker) else { return }
        
        favorites.remove(at: index)
        UserDefaults.standard.set(favorites, forKey: key)
        fetchCompanies()
    }
}
