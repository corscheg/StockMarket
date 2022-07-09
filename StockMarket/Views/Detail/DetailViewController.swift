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
        logoImageView.backgroundColor = .white
        logoImageView.layer.cornerCurve = .continuous
        logoImageView.layer.cornerRadius = 30
        logoImageView.clipsToBounds = true
        logoImageView.layer.borderWidth = 2
        logoImageView.layer.borderColor = UIColor.systemGray2.cgColor
//        logoImageView.layer.shadowColor = UIColor.black.cgColor
//        logoImageView.layer.shadowRadius = 10
//        logoImageView.layer.shadowOpacity = 1
//        logoImageView.layer.shadowPath = UIBezierPath(rect: logoImageView.bounds).cgPath
//        logoImageView.layer.shadowOffset = .zero
        view.addSubview(logoImageView)
        
        logoImageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = false

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
        
        guard let imageData = company.logoImageData, let image = UIImage(data: imageData) else {
            logoImageView.image = UIImage(systemName: "photo")
            return
        }
        logoImageView.image = image
    }
}

extension DetailViewController {
    private func notifyPresenterLoaded() {
        presenter.isAbleToManipulate()
    }
}
