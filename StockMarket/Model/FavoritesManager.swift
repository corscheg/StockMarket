//
//  FavoritesManager.swift
//  StockMarket
//
//  Created by Александр Казак-Казакевич on 11.07.2022.
//

import Foundation

class FavoritesManager {
    private let key = "favorites"
    
    private(set) var favorites: [Company]
    
    public static var shared = FavoritesManager()
    
    private init() {
        if let data = UserDefaults.standard.data(forKey: key) {
            if let companies = try? JSONDecoder().decode([Company].self, from: data) {
                favorites = companies
            } else {
                fatalError("Invalid favorites format!!!")
            }
        } else {
            favorites = []
        }
    }

    func save() {
        if let data = try? JSONEncoder().encode(favorites) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }
    
    func add(_ company: Company) {
        favorites.append(company)
        save()
    }
    
    func remove(_ company: Company) {
        if let index = favorites.firstIndex(of: company) {
            favorites.remove(at: index)
            save()
        }
    }
    
    func refreshData() async {
        let tickers = favorites.map { $0.ticker }
        var refreshed = [Company]()
        
        for i in 0..<tickers.count {
            if let new = try? await CompanyFetcher.shared.fetchCompany(with: tickers[i]) {
                refreshed.append(new)
            } else {
                refreshed.append(favorites[i])
            }
        }
        
        favorites = refreshed
        save()
    }
    
    func isFavoriteBy(ticker: String) -> Bool {
        let tickers = favorites.map { $0.ticker }
        if let _ = tickers.firstIndex(of: ticker) {
            return true
        }
        return false
    }
}
