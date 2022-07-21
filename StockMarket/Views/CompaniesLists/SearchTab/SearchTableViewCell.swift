//
//  SearchTableViewCell.swift
//  StockMarket
//
//  Created by Александр Казак-Казакевич on 06.07.2022.
//

import UIKit

/// A table view cell for displaying a company.
class SearchTableViewCell: UITableViewCell {

    private var nameLabel: UILabel!
    private var tickerLabel: UILabel!
    private var hStack: UIStackView!
    private var innerHStack: UIStackView!
    private var star: UIImageView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        accessoryType = .disclosureIndicator
        backgroundColor = .systemGray5
        
        // hStack contains name, ticker and favorites marker.
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
        
        // innerHStack contains ticker and favorites marker.
        innerHStack = UIStackView()
        innerHStack.translatesAutoresizingMaskIntoConstraints = false
        innerHStack.axis = .horizontal
        innerHStack.alignment = .center
        innerHStack.distribution = .equalSpacing
        innerHStack.spacing = 10
        innerHStack.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 760), for: .horizontal)
        hStack.addArrangedSubview(innerHStack)
        
        tickerLabel = UILabel()
        tickerLabel.translatesAutoresizingMaskIntoConstraints = false
        tickerLabel.numberOfLines = 1
        tickerLabel.font = .preferredFont(forTextStyle: .subheadline)
        tickerLabel.setContentCompressionResistancePriority(UILayoutPriority(770), for: .horizontal)
        innerHStack.addArrangedSubview(tickerLabel)
        
        star = UIImageView()
        star.translatesAutoresizingMaskIntoConstraints = false
        innerHStack.addArrangedSubview(star)
        
        star.widthAnchor.constraint(equalTo: star.heightAnchor).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    /// Configure a cell for representing a certain company.
    func configure(for company: Company) {
        nameLabel.text = company.name
        tickerLabel.text = company.ticker
        
        star.image = company.isFavorite ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
    }

}
