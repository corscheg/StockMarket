//
//  DataFetcher.swift
//  StockMarket
//
//  Created by Александр Казак-Казакевич on 06.07.2022.
//

import Foundation

/// A base class that implements common properties for other data fetchers.
/// *You shouldn't initialize instances of this class.*
class DataFetcher {
    
    /// An enum for common data-fetching errors.
    enum DataFetchingError: Error {
        case invalidURL
    }
    
    /// A key received from account on finnhub.io used for API access
    var apiKey: String
    
    /// A property stores the base URL components common for all subclasses
    var components: URLComponents
    
    /// Initializer used by `DataFetcher` subclasses.
    init() {
        
        // Initialize the apiKey property from the file placed in the Bundle
        guard let keyURL = Bundle.main.url(forResource: "key", withExtension: "txt"), let key = try? String(contentsOf: keyURL) else {
            fatalError("There are no key.txt file in the bundle!!!")
        }
        apiKey = key.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Make the base components property with common scheme and host
        components = URLComponents()
        components.scheme = "https"
        components.host = "finnhub.io"
    }
}
