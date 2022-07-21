//
//  DetailPresenter.swift
//  StockMarket
//
//  Created by Александр Казак-Казакевич on 08.07.2022.
//

import Foundation

/// A cllass that manages data for `DetailViewController`s.
class DetailPresenter {
    
    /// A company that is presented.
    var company: Company
    
    /// A reference to the view.
    weak var view: DetailViewController?
    
    /// An initializer that fetches prices and sets it's own state according to the given company.
    init(company: Company) {
        self.company = company
        
        Task {
            do {
                
                // Fetch the company's prices
                let day = try await PricesFetcher.shared.fetchPrices(for: company.ticker)
                self.company.today = day
                
                // Update the view on the main thread
                DispatchQueue.main.async { [weak self] in
                    self?.setCompanyIntoView()
                    self?.updateView()
                }
                
            } catch {
                
                // TODO: Add error AlertController
                print(error)
            }
        }
    }
}

extension DetailPresenter {
    
    /// Pushes the `company` property to the view.
    private func setCompanyIntoView() {
        view?.set(company: company)
    }
    
    /// Updates the view state.
    private func updateView() {
        view?.updateUI()
    }
}

extension DetailPresenter {
    
    /// Should be called after view is loaded, and it's methods can be called.
    func isAbleToManipulate() {
        setCompanyIntoView()
    }
    
    /// Makes a company favorite if it wasn't, and vice versa.
    func switchFavorite() {
        if company.isFavorite {
            FavoritesManager.shared.remove(company)
        } else {
            FavoritesManager.shared.add(company)
        }
        
        updateView()
    }
    
}
