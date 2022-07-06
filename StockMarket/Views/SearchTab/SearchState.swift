//
//  SearchState.swift
//  StockMarket
//
//  Created by Александр Казак-Казакевич on 04.07.2022.
//

import Foundation

enum SearchState {
    case prompt
    case found(name: String)
    case notFound
    case inProgress
}
