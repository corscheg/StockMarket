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
        if let companies = UserDefaults.standard.object(forKey: key) {
            if let castedCompanies = companies as? [Company] {
                favorites = castedCompanies
            } else {
                fatalError("Invalid favorites format!!!")
            }
        } else {
            favorites = [
                Company(name: "Apple Inc", ticker: "AAPL", industry: "Technology"),
                Company(name: "Microsoft Inc", ticker: "MSFT", industry: "Technology")
            ]
        }
    }

    func save() {
        UserDefaults.standard.set(favorites, forKey: key)
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
}
