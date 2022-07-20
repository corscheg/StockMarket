//
//  PriceStackView.swift
//  StockMarket
//
//  Created by Александр Казак-Казакевич on 20.07.2022.
//

import UIKit

class PriceStackView: UIStackView {
    var label: UILabel
    var price: UILabel
    
    init() {
        label = UILabel()
        price = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .caption1)
        
        price.translatesAutoresizingMaskIntoConstraints = false
        price.font = .preferredFont(forTextStyle: .title3)
        
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
        axis = .horizontal
        distribution = .fill
        alignment = .firstBaseline
        addArrangedSubview(label)
        addArrangedSubview(price)
    }
    
    required init(coder: NSCoder) {
        label = UILabel()
        price = UILabel()
        super.init(coder: coder)
    }
    
    func set(price: Double, for description: String) {
        label.text = description
        self.price.text = String(price)
    }
}
