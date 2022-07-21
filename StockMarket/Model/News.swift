//
//  News.swift
//  StockMarket
//
//  Created by Александр Казак-Казакевич on 20.07.2022.
//

import Foundation

/// A struct that represents a news about a company or something else.
struct News: Decodable, Hashable {
    
    private enum CodingKeys: String, CodingKey {
        case category
        case dateTime = "datetime"
        case title = "headline"
        case imageURL = "image"
        case related
        case source
        case summary
        case url
    }
    
    /// A category of the news.
    let category: String
    
    /// A date and time.
    let dateTime: Date
    
    /// A headline of the news.
    let title: String
    
    /// An URL for possible image.
    var imageURL: URL?
    
    /// Data containing the possible image.
    var imageData: Data?
    
    /// Some related data.
    let related: String
    
    /// An initial source of the news.
    let source: String
    
    /// A string representing the summary.
    let summary: String
    
    /// A link to the source.
    var url: URL?
    
    /// Initializer for JSON Decoding.
    /// - Precondition: `JSONDecoder().dateDecodingStrategy = .secondsSince1970`
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.category = try container.decode(String.self, forKey: .category)
        self.dateTime = try container.decode(Date.self, forKey: .dateTime)
        self.title = try container.decode(String.self, forKey: .title)
        
        // URL is nil if image does not exist
        let imageStringURL = try container.decode(String.self, forKey: .imageURL)
        self.imageURL = URL(string: imageStringURL)
        
        self.related = try container.decode(String.self, forKey: .related)
        self.source = try container.decode(String.self, forKey: .source)
        self.summary = try container.decode(String.self, forKey: .summary)
        
        // URL is nil if source does not exist
        let stringURL = try container.decode(String.self, forKey: .url)
        self.url = URL(string: stringURL)
    }
}
