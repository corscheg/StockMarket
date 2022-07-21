//
//  DetailViewController.swift
//  StockMarket
//
//  Created by Александр Казак-Казакевич on 08.07.2022.
//

import UIKit
import SafariServices

/// A ViewController that presents a detais about a company at the separate page.
class DetailViewController: UIViewController {
    
    /// A presenter used to manage data.
    var presenter: DetailPresenter!
    
    /// A company ViewController presents.
    private var company: Company!
    
    private var topHStack: UIStackView!
    private var vStack: UIStackView!
    private var hStack: UIStackView!
    private var favStack: UIStackView!
    
    private var logoImageView: UIImageView!
    private var nameLabel: UILabel!
    private var tickerLabel: UILabel!
    private var industryLabel: UILabel!
    private var websiteButton: UIButton!
    private var star: UIImageView!
    private var addRemoveFavoriteButton: UIButton!
    
    private var pricesStack: UIStackView!
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .systemGray6
        
        // topHStack contains logo, name, ticker and industry of the company.
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
        
        // logoImageView shows the logo of the company.
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
        
        // vStack contains name, ticker and industry of the company.
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
        
        // hStack contains ticker and industry of the company.
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
        
        // A button that is used for reaching the website of the company.
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
        
        // favStack contains star representing whether the company is favorite, and button to switch that state.
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
        
        // pricesStack contains intraday prices of the company.
        pricesStack = UIStackView()
        pricesStack.translatesAutoresizingMaskIntoConstraints = false
        pricesStack.axis = .vertical
        pricesStack.alignment = .center
        pricesStack.distribution = .equalSpacing
        pricesStack.spacing = 8
        view.addSubview(pricesStack)
        
        // Fill the pricesStack with views containing particular price values
        for _ in 1...7 {
            let psv = PriceStackView()
            pricesStack.addArrangedSubview(psv)
            
            psv.leftAnchor.constraint(equalTo: pricesStack.leftAnchor).isActive = true
            psv.rightAnchor.constraint(equalTo: pricesStack.rightAnchor).isActive = true
        }
        
        pricesStack.topAnchor.constraint(equalTo: favStack.bottomAnchor, constant: 20).isActive = true
        pricesStack.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        pricesStack.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.5).isActive = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never

        // Say presenter that it can manipulate the view
        notifyPresenterLoaded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
    }
    
    @objc func showWebsite() {
        
        // Show the company's website if URL exists.
        if let url = company.websiteURL {
            present(SFSafariViewController(url: url), animated: true)
        }
    }
    
    @objc func addRemoveTapped() {
        
        // Notify presenter that 'favorite' state must be changed
        switchFavorite()
    }
}

extension DetailViewController {
    
    /// Sets the company for displaying and updates UI.
    func set(company: Company) {
        self.company = company
        
        updateUI()
    }
    
    /// Updates UI.
    func updateUI() {
        
        // Fill the labels with proper values.
        nameLabel.text = company.name
        navigationItem.title = company.name
        tickerLabel.text = company.ticker
        industryLabel.text = company.industry
        
        // Fill the price views
        if let day = company.today {
            if let stack = pricesStack.arrangedSubviews[0] as? PriceStackView {
                stack.set(price: day.current, for: "Price")
            }
            if let stack = pricesStack.arrangedSubviews[1] as? PriceStackView {
                stack.set(price: day.delta, for: "Delta")
            }
            if let stack = pricesStack.arrangedSubviews[2] as? PriceStackView {
                stack.set(price: day.deltaPercent, for: "Delta Percent")
            }
            if let stack = pricesStack.arrangedSubviews[3] as? PriceStackView {
                stack.set(price: day.open, for: "Open")
            }
            if let stack = pricesStack.arrangedSubviews[4] as? PriceStackView {
                stack.set(price: day.low, for: "Low")
            }
            if let stack = pricesStack.arrangedSubviews[5] as? PriceStackView {
                stack.set(price: day.high, for: "High")
            }
            if let stack = pricesStack.arrangedSubviews[6] as? PriceStackView {
                stack.set(price: day.previousClose, for: "Previous Close")
            }
        }
        
        // Sets the websiteButton state according to the availability of the URL.
        if company.websiteURL == nil {
            websiteButton.isEnabled = false
            websiteButton.backgroundColor = .systemGray3
            websiteButton.setTitle("Website is unavailable", for: .normal)
        } else {
            websiteButton.isEnabled = true
            websiteButton.backgroundColor = .systemBlue
            websiteButton.setTitle("Go to website", for: .normal)
        }
        
        // Sets the 'favorite' section state according to the state of the company.
        if company.isFavorite {
            star.image = UIImage(systemName: "star.fill")
            addRemoveFavoriteButton.setTitle("Remove from Favorites", for: .normal)
        } else {
            star.image = UIImage(systemName: "star")
            addRemoveFavoriteButton.setTitle("Add to Favorites", for: .normal)
        }
        
        // Sets the logo image or a placeholder
        guard let imageData = company.logoImageData, let image = UIImage(data: imageData) else {
            logoImageView.image = UIImage(systemName: "photo")
            return
        }
        logoImageView.image = image
    }
}

extension DetailViewController {
    
    /// Says presenter that ViewController is ready to manipulations.
    private func notifyPresenterLoaded() {
        presenter.isAbleToManipulate()
    }
    
    /// Says presenter that it must switch 'favorite' state.
    private func switchFavorite() {
        presenter.switchFavorite()
    }
}
