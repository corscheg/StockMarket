//
//  Company.swift
//  StockMarket
//
//  Created by Александр Казак-Казакевич on 06.07.2022.
//

import Foundation

struct Company: Decodable, Hashable {
    
    enum CodingKeys: String, CodingKey {
        case name
        case ticker
        case industry = "finnhubIndustry"
        case logoURL = "logo"
        case websiteURL = "weburl"
        
    }
    
    var name: String
    var ticker: String
    var industry: String
    var logoURL: URL?
    var logoImageData: Data?
    var websiteURL: URL?
    
    var isFavorite: Bool {
        FavoritesManager.shared.isFavoriteBy(ticker: ticker)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try container.decode(String.self, forKey: .name)
        ticker = try container.decode(String.self, forKey: .ticker)
        industry = try container.decode(String.self, forKey: .industry)
        
        logoURL = try? URL(string: container.decode(String.self, forKey: .logoURL))
        websiteURL = try? URL(string: container.decode(String.self, forKey: .websiteURL))
    }
    
    init(name: String, ticker: String, industry: String) {
        self.name = name
        self.ticker = ticker
        self.industry = industry
    }
}
