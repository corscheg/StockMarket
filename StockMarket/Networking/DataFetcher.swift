//
//  DataFetcher.swift
//  StockMarket
//
//  Created by Александр Казак-Казакевич on 06.07.2022.
//

import Foundation

class DataFetcher {
    
    enum DataFetchingError: Error {
        case invalidURL
    }
    
    var apiKey: String
    var components: URLComponents
    
    init() {
        guard let keyURL = Bundle.main.url(forResource: "key", withExtension: "txt"), let key = try? String(contentsOf: keyURL) else {
            fatalError("There are no key.txt file in the bundle!!!")
        }
        apiKey = key.trimmingCharacters(in: .whitespacesAndNewlines)
        
        components = URLComponents()
        components.scheme = "https"
        components.host = "finnhub.io"
    }
}
