//
//  File.swift
//  StockMarket
//
//  Created by Александр Казак-Казакевич on 20.07.2022.
//

import Foundation

struct TradingDay: Codable, Hashable {
    enum CodingKeys: String, CodingKey {
        case current = "c"
        case delta = "d"
        case deltaPercent = "dp"
        case high = "h"
        case low = "l"
        case open = "o"
        case previousClose = "pc"
    }
    
    let current: Double
    let delta: Double
    let deltaPercent: Double
    let high: Double
    let low: Double
    let open: Double
    let previousClose: Double
}
