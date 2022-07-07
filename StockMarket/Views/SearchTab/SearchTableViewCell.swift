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
    var hStack: UIStackView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        hStack = UIStackView()
        hStack.translatesAutoresizingMaskIntoConstraints = false
        hStack.axis = .horizontal
        hStack.alignment = .center
        hStack.distribution = .equalSpacing
        addSubview(hStack)
        
        hStack.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        hStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        hStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        hStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        
        nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.numberOfLines = 1
        nameLabel.font = .preferredFont(forTextStyle: .title1)
        hStack.addArrangedSubview(nameLabel)
        
        tickerLabel = UILabel()
        tickerLabel.translatesAutoresizingMaskIntoConstraints = false
        tickerLabel.numberOfLines = 1
        tickerLabel.font = .preferredFont(forTextStyle: .title3)
        hStack.addArrangedSubview(tickerLabel)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configure(for company: Company) {
        nameLabel.text = company.name
        tickerLabel.text = company.ticker
    }

}
