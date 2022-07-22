//
//  PriceStackView.swift
//  StockMarket
//
//  Created by Александр Казак-Казакевич on 20.07.2022.
//

import UIKit

/// A view that is used for displaying a price with it's label.
class PriceStackView: UIStackView {
    private var label: UILabel
    private var price: UILabel
    
    /// Initializes an empty view.
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
    
    /// Sets view's fieds according to the price and description.
    /// - Parameter price: A `Double` representing the price.
    /// - Parameter description: A label.
    func set(price: Double, for description: String) {
        label.text = description
        
        // Add percent sign if needed
        if description == "Delta Percent" {
            self.price.text = "\(price) %"
        } else {
            self.price.text = String(price)
        }
    }
}
