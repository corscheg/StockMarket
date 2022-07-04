//
//  TradingDay.swift
//  StockMarket
//
//  Created by Александр Казак-Казакевич on 04.07.2022.
//

import Foundation

struct TradingDay: Decodable {
    enum CodingKeys: String, CodingKey {
        case open = "1. open"
        case close = "4. close"
        case high = "2. high"
        case low = "3. low"
    }
    
    enum DecodingErrors: Error {
        case canNotMakeDouble
    }
    
    var open: Double
    var close: Double
    var high: Double
    var low: Double
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        guard let open = try? Double(container.decode(String.self, forKey: .open)),
              let close = try? Double(container.decode(String.self, forKey: .close)),
              let high = try? Double(container.decode(String.self, forKey: .high)),
              let low = try? Double(container.decode(String.self, forKey: .low)) else {
            throw DecodingErrors.canNotMakeDouble
        }
        
        self.open = open
        self.close = close
        self.high = high
        self.low = low
    }
}
