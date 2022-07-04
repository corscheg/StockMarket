//
//  SearchPromptView.swift
//  StockMarket
//
//  Created by Александр Казак-Казакевич on 04.07.2022.
//

import UIKit

class SearchPromptView: UIView {
    
    var prompt: UILabel!
    
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
        
    }
    
    func createSubviews() {
        prompt = UILabel()
        prompt.translatesAutoresizingMaskIntoConstraints = false
        prompt.text = "Please type the ticker in the search field."
        prompt.font = .preferredFont(forTextStyle: .largeTitle)
        prompt.numberOfLines = 0
        prompt.textAlignment = .center
        addSubview(prompt)
        
        prompt.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        prompt.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        prompt.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        prompt.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        
    }

}
