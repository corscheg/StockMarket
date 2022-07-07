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
        
        accessoryType = .disclosureIndicator
        
        hStack = UIStackView()
        hStack.translatesAutoresizingMaskIntoConstraints = false
        hStack.axis = .horizontal
        hStack.alignment = .center
        hStack.distribution = .equalSpacing
        addSubview(hStack)
        
        hStack.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        hStack.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.9).isActive = true
        hStack.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        hStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        
        nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.numberOfLines = 1
        nameLabel.font = .preferredFont(forTextStyle: .title2)
        hStack.addArrangedSubview(nameLabel)
        
        tickerLabel = UILabel()
        tickerLabel.translatesAutoresizingMaskIntoConstraints = false
        tickerLabel.numberOfLines = 1
        tickerLabel.font = .preferredFont(forTextStyle: .subheadline)
        tickerLabel.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 760), for: .horizontal)
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
