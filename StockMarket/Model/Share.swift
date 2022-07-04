//
//  Share.swift
//  StockMarket
//
//  Created by Александр Казак-Казакевич on 04.07.2022.
//

import Foundation

struct Share {
    var ticker: String
    var prices: [Date: TradingDay]
}
