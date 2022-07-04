//
//  Share.swift
//  StockMarket
//
//  Created by Александр Казак-Казакевич on 04.07.2022.
//

import Foundation

struct Share: Decodable {
    enum CodingKeys: String, CodingKey {
        case metaData = "Meta Data"
        case prices = "Time Series (Daily)"
    }
    
    enum MetaDataCodingKeys: String, CodingKey {
        case ticker = "2. Symbol"
    }
    
    enum DecodingErrors: Error {
        case canNotConvertToDate
    }
    
    var ticker: String
    var prices: [Date: TradingDay]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let metaData = try container.nestedContainer(keyedBy: MetaDataCodingKeys.self, forKey: .metaData)
        
        ticker = try metaData.decode(String.self, forKey: .ticker)
        
        let pricesDict = try container.decode([String: TradingDay].self, forKey: .prices)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        prices = [:]
        
        for (key, value) in pricesDict {
            if let date = formatter.date(from: key) {
                prices[date] = value
            } else {
                throw DecodingErrors.canNotConvertToDate
            }
        }
    }
}
