//
//  SearchFoundView.swift
//  StockMarket
//
//  Created by Александр Казак-Казакевич on 04.07.2022.
//

import UIKit

class SearchFoundView: UIView {
    
    var text: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setProperties()
        
        createSubviews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setProperties()
        
        createSubviews()
    }
    
    func setProperties() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 2
        layer.cornerCurve = .continuous
        layer.cornerRadius = 10
        backgroundColor = .systemGreen
    }
    
    func createSubviews() {
        text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.text = "FOUND PLACEHOLDER"
        text.font = .preferredFont(forTextStyle: .largeTitle)
        text.numberOfLines = 0
        text.textAlignment = .center
        addSubview(text)
        
        text.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        text.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        text.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        text.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        
    }
    
}
