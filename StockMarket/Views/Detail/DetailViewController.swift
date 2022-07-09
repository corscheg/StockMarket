//
//  DetailViewController.swift
//  StockMarket
//
//  Created by Александр Казак-Казакевич on 08.07.2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    var presenter: DetailPresenter!
    
    var company: Company!
    
    var nameLabel: UILabel!
    var logoImageView: UIImageView!
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .systemGray6
        
        nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameLabel)
        
        nameLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        
        logoImageView = UIImageView()
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logoImageView)
        
        logoImageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = false
        
        // TEMP
        logoImageView.image = UIImage(systemName: "pc")

        notifyPresenterLoaded()
    }
}

extension DetailViewController {
    func set(company: Company) {
        self.company = company
        
        updateUI()
    }
    
    func updateUI() {
        nameLabel.text = company.name
        navigationItem.title = company.name
        
        if let imageData = company.logoImageData {
            if let image = UIImage(data: imageData) {
                logoImageView.image = image
            }
        }
    }
}

extension DetailViewController {
    private func notifyPresenterLoaded() {
        presenter.isAbleToManipulate()
    }
}
