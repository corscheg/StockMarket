//
//  File.swift
//  StockMarket
//
//  Created by Александр Казак-Казакевич on 20.07.2022.
//

import Foundation

/// A struct that represents intraday prices for some company.
struct TradingDay: Codable, Hashable {
    private enum CodingKeys: String, CodingKey {
        case current = "c"
        case delta = "d"
        case deltaPercent = "dp"
        case high = "h"
        case low = "l"
        case open = "o"
        case previousClose = "pc"
    }
    
    /// The latest price.
    let current: Double
    
    /// Change of the price
    let delta: Double
    
    /// Percent change
    let deltaPercent: Double
    
    /// The intraday high.
    let high: Double
    
    /// The intraday low.
    let low: Double
    
    /// The open price.
    let open: Double
    
    /// The previous day close price.
    let previousClose: Double
}
