//
//  News.swift
//  StockMarket
//
//  Created by Александр Казак-Казакевич on 20.07.2022.
//

import Foundation

struct News: Decodable, Hashable {
    enum CodingKeys: String, CodingKey {
        case category
        case dateTime = "datetime"
        case title = "headline"
        case imageURL = "image"
        case related
        case source
        case summary
        case url
    }
    
    let category: String
    let dateTime: Date
    let title: String
    var imageURL: URL?
    var imageData: Data?
    let related: String
    let source: String
    let summary: String
    var url: URL?
    
    /// Initializer for JSON Decoding.
    /// - Precondition: `JSONDecoder().dateDecodingStrategy = .secondsSince1970`
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.category = try container.decode(String.self, forKey: .category)
        self.dateTime = try container.decode(Date.self, forKey: .dateTime)
        self.title = try container.decode(String.self, forKey: .title)
        
        let imageStringURL = try container.decode(String.self, forKey: .imageURL)
        self.imageURL = URL(string: imageStringURL)
        
        self.related = try container.decode(String.self, forKey: .related)
        self.source = try container.decode(String.self, forKey: .source)
        self.summary = try container.decode(String.self, forKey: .summary)
        
        let stringURL = try container.decode(String.self, forKey: .url)
        self.url = URL(string: stringURL)
    }
}
