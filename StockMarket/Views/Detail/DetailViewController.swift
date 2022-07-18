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
    var favStack: UIStackView!
    
    var logoImageView: UIImageView!
    var nameLabel: UILabel!
    var tickerLabel: UILabel!
    var industryLabel: UILabel!
    var websiteButton: UIButton!
    var star: UIImageView!
    var addRemoveFavoriteButton: UIButton!
    
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
        
        favStack = UIStackView()
        favStack.translatesAutoresizingMaskIntoConstraints = false
        favStack.axis = .horizontal
        favStack.alignment = .center
        favStack.distribution = .fill
        favStack.spacing = 10
        view.addSubview(favStack)
        
        favStack.topAnchor.constraint(equalTo: websiteButton.bottomAnchor, constant: 10).isActive = true
        favStack.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        favStack.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.7).isActive = true
        
        star = UIImageView()
        star.translatesAutoresizingMaskIntoConstraints = false
        star.setContentCompressionResistancePriority(UILayoutPriority(260), for: .horizontal)
        star.image = UIImage(systemName: "star")
        favStack.addArrangedSubview(star)
        
        star.widthAnchor.constraint(equalTo: star.heightAnchor).isActive = true
        
        addRemoveFavoriteButton = UIButton()
        addRemoveFavoriteButton.translatesAutoresizingMaskIntoConstraints = false
        addRemoveFavoriteButton.backgroundColor = .systemBlue
        addRemoveFavoriteButton.layer.cornerCurve = .continuous
        addRemoveFavoriteButton.layer.cornerRadius = 10
        addRemoveFavoriteButton.addTarget(self, action: #selector(addRemoveTapped), for: .touchUpInside)
        addRemoveFavoriteButton.setTitle("Hi", for: .normal)
        favStack.addArrangedSubview(addRemoveFavoriteButton)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never

        notifyPresenterLoaded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
    }
    
    @objc func showWebsite() {
        if let url = company.websiteURL {
            present(SFSafariViewController(url: url), animated: true)
        }
    }
    
    @objc func addRemoveTapped() {
        switchFavorite()
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
        
        if company.isFavorite {
            star.image = UIImage(systemName: "star.fill")
            addRemoveFavoriteButton.setTitle("Remove from Favorites", for: .normal)
        } else {
            star.image = UIImage(systemName: "star")
            addRemoveFavoriteButton.setTitle("Add to Favorites", for: .normal)
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
    
    private func switchFavorite() {
        presenter.switchFavorite()
    }
}
