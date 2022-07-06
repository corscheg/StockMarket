//
//  Networking.swift
//  StockMarket
//
//  Created by Александр Казак-Казакевич on 04.07.2022.
//

import Foundation

class ShareFetcher {
    
    enum FetchingError: Error {
        case invalidURL, unknownServerResponse, shareNotFound
    }
    
    public static var shared = ShareFetcher()
    
    private var apiKeys: [String] = {
        guard let url = Bundle.main.url(forResource: "key", withExtension: "txt"), let inlineKeys = try? String(contentsOf: url) else {
            fatalError("There is not an API keys in the app Bundle!!!")
        }
        
        let keys = inlineKeys.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: "\n")
        return keys
        
    }()
    
    private var apiKey: String {
        apiKeys[currentKeyIndex]
    }
    
    private var currentKeyIndex = 0
    
    func fetchShare(withTicker ticker: String) async throws -> Share {
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "www.alphavantage.co"
        components.path = "/query"
        let function = URLQueryItem(name: "function", value: "TIME_SERIES_DAILY")
        let company = URLQueryItem(name: "symbol", value: ticker)
        let key = URLQueryItem(name: "apikey", value: apiKey)
        components.queryItems = [function, company, key]
        
        guard let url = components.url else {
            throw FetchingError.invalidURL
        }
        
        let request = URLRequest(url: url)
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let decoder = JSONDecoder()
        
        let share: Share
        
        do {
            share = try decoder.decode(Share.self, from: data)
        } catch {
            guard let response = String(data: data, encoding: .utf8) else {
                throw FetchingError.unknownServerResponse
            }
            
            /*
            if response.contains("Error Message") {
                throw FetchingError.shareNotFound
            } else if response.contains("Note") {
                switchKey()
                share = try await fetchShare(withTicker: ticker)
            } else {
                throw FetchingError.unknownServerResponse
            }
             */
            
            
            switch response {
            case let response where response.contains("Error Message"):
                throw FetchingError.shareNotFound
            case let response where response.contains("Note"):
                switchKey()
                share = try await fetchShare(withTicker: ticker)
            default:
                throw FetchingError.unknownServerResponse
            }
        }
        
        return share
    }
    
    private func switchKey() {
        if currentKeyIndex < apiKeys.count - 1 {
            currentKeyIndex += 1
        } else {
            currentKeyIndex = 0
        }
    }
}
