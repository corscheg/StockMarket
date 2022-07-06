//
//  SearchTableViewCell.swift
//  StockMarket
//
//  Created by Александр Казак-Казакевич on 06.07.2022.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    var nameLabel: UILabel!
    var tickerLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.numberOfLines = 1
        nameLabel.font = .preferredFont(forTextStyle: .title1)
        addSubview(nameLabel)
        
        nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        
        tickerLabel = UILabel()
        tickerLabel.translatesAutoresizingMaskIntoConstraints = false
        tickerLabel.numberOfLines = 1
        tickerLabel.font = .preferredFont(forTextStyle: .title3)
        addSubview(tickerLabel)
        
        tickerLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        tickerLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configure(for company: Company) {
        nameLabel.text = company.name
        tickerLabel.text = company.ticker
    }

}
