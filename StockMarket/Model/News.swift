//
//  News.swift
//  StockMarket
//
//  Created by Александр Казак-Казакевич on 20.07.2022.
//

import Foundation

struct News: Codable, Hashable {
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
}
