//
//  Company.swift
//  StockMarket
//
//  Created by Александр Казак-Казакевич on 06.07.2022.
//

import Foundation

/// A struct that represents a company.
struct Company: Codable, Hashable {
    
    private enum CodingKeys: String, CodingKey {
        case name
        case ticker
        case industry = "finnhubIndustry"
        case logoURL = "logo"
        case websiteURL = "weburl"
        case logoImageData
    }
    
    /// A name of the company.
    var name: String
    
    /// A symbol of the company.
    var ticker: String
    
    /// An industry of the company.
    var industry: String
    
    /// An URL pointing to the logo image.
    var logoURL: URL?
    
    /// Data representing the logo image.
    var logoImageData: Data?
    
    /// An URL of the company's website.
    var websiteURL: URL?
    
    /// A property containing intraday prices of the company's stock.
    var today: TradingDay?
    
    /// Checks if the company is present in favorites.
    var isFavorite: Bool {
        FavoritesManager.shared.isFavoriteBy(ticker: ticker)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try container.decode(String.self, forKey: .name)
        ticker = try container.decode(String.self, forKey: .ticker)
        industry = try container.decode(String.self, forKey: .industry)
        
        // URLs stay nil if there was some problems
        logoURL = try? URL(string: container.decode(String.self, forKey: .logoURL))
        websiteURL = try? URL(string: container.decode(String.self, forKey: .websiteURL))
    }
    
    /// A memberwise initializer.
    init(name: String, ticker: String, industry: String) {
        self.name = name
        self.ticker = ticker
        self.industry = industry
    }
}
