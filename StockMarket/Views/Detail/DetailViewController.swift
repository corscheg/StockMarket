//
//  DetailViewController.swift
//  StockMarket
//
//  Created by Александр Казак-Казакевич on 08.07.2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    var presenter: DetailPresenter!
    
    var nameLabel: UILabel!
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .systemGray6
        
        nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameLabel)
        
        nameLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        notifyPresenterLoaded()
    }
}

extension DetailViewController {
    func setDetails(name: String) {
        nameLabel.text = name
    }
}

extension DetailViewController {
    private func notifyPresenterLoaded() {
        presenter.isAbleToManipulate()
    }
}
