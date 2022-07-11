//
//  DetailViewController.swift
//  StockMarket
//
//  Created by Александр Казак-Казакевич on 08.07.2022.
//

import UIKit
import SafariServices

class DetailViewController: UIViewController {
    
    var presenter: DetailPresenter!
    
    var company: Company!
    
    var topHStack: UIStackView!
    var vStack: UIStackView!
    var hStack: UIStackView!
    
    var logoImageView: UIImageView!
    var nameLabel: UILabel!
    var tickerLabel: UILabel!
    var industryLabel: UILabel!
    var websiteButton: UIButton!
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .systemGray6
        
        topHStack = UIStackView()
        topHStack.translatesAutoresizingMaskIntoConstraints = false
        topHStack.axis = .horizontal
        topHStack.alignment = .center
        topHStack.distribution = .fill
        topHStack.spacing = 20
        view.addSubview(topHStack)
        
        topHStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        topHStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        topHStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        topHStack.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        logoImageView = UIImageView()
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.backgroundColor = .white
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.layer.cornerCurve = .continuous
        logoImageView.layer.cornerRadius = 30
        logoImageView.clipsToBounds = true
        logoImageView.layer.borderWidth = 2
        logoImageView.layer.borderColor = UIColor.systemGray2.cgColor
        logoImageView.setContentHuggingPriority(UILayoutPriority(260), for: .horizontal)
//        logoImageView.layer.shadowColor = UIColor.black.cgColor
//        logoImageView.layer.shadowRadius = 10
//        logoImageView.layer.shadowOpacity = 1
//        logoImageView.layer.shadowPath = UIBezierPath(rect: logoImageView.bounds).cgPath
//        logoImageView.layer.shadowOffset = .zero
        topHStack.addArrangedSubview(logoImageView)
        
        logoImageView.heightAnchor.constraint(equalTo: topHStack.heightAnchor).isActive = true
        logoImageView.widthAnchor.constraint(equalTo: logoImageView.heightAnchor).isActive = true
        
        vStack = UIStackView()
        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.axis = .vertical
        vStack.alignment = .leading
        vStack.distribution = .equalSpacing
        vStack.spacing = 10
        topHStack.addArrangedSubview(vStack)
        
        nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = .systemFont(ofSize: 32, weight: .bold)
        nameLabel.textAlignment = .left
        vStack.addArrangedSubview(nameLabel)
        
        hStack = UIStackView()
        hStack.translatesAutoresizingMaskIntoConstraints = false
        hStack.axis = .horizontal
        hStack.alignment = .firstBaseline
        hStack.distribution = .fill
        vStack.addArrangedSubview(hStack)
        
        hStack.widthAnchor.constraint(equalTo: vStack.widthAnchor).isActive = true
        
        tickerLabel = UILabel()
        tickerLabel.translatesAutoresizingMaskIntoConstraints = false
        tickerLabel.font = .systemFont(ofSize: 20, weight: .regular)
        tickerLabel.textColor = .systemGray
        tickerLabel.textAlignment = .left
        hStack.addArrangedSubview(tickerLabel)
        
        industryLabel = UILabel()
        industryLabel.translatesAutoresizingMaskIntoConstraints = false
        industryLabel.font = .systemFont(ofSize: 16, weight: .light)
        industryLabel.textColor = .systemGray2
        industryLabel.textAlignment = .right
        hStack.addArrangedSubview(industryLabel)
        
        websiteButton = UIButton()
        websiteButton.translatesAutoresizingMaskIntoConstraints = false
        websiteButton.backgroundColor = .systemRed
        websiteButton.layer.cornerCurve = .continuous
        websiteButton.layer.cornerRadius = 10
        websiteButton.addTarget(self, action: #selector(showWebsite), for: .touchUpInside)
        view.addSubview(websiteButton)
        
        websiteButton.topAnchor.constraint(equalTo: topHStack.bottomAnchor, constant: 10).isActive = true
        websiteButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        websiteButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = false

        notifyPresenterLoaded()
    }
    
    @objc func showWebsite() {
        if let url = company.websiteURL {
            present(SFSafariViewController(url: url), animated: true)
        }
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
        tickerLabel.text = company.ticker
        industryLabel.text = company.industry
        
        
        
        if company.websiteURL == nil {
            websiteButton.isEnabled = false
            websiteButton.backgroundColor = .systemGray3
            websiteButton.setTitle("Website is unavailable", for: .normal)
        } else {
            websiteButton.isEnabled = true
            websiteButton.backgroundColor = .systemBlue
            websiteButton.setTitle("Go to website", for: .normal)
        }
        
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