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
    }
    
    var name: String
    var ticker: String
    var industry: String
    
}
