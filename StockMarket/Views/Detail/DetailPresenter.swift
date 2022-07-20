//
//  DetailPresenter.swift
//  StockMarket
//
//  Created by Александр Казак-Казакевич on 08.07.2022.
//

import Foundation

class DetailPresenter {
    var company: Company
    
    weak var view: DetailViewController?
    
    init(company: Company) {
        self.company = company
        
        Task {
            do {
                let day = try await PricesFetcher.shared.fetchPrices(for: company.ticker)
                self.company.today = day
                
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
    private func setCompanyIntoView() {
        view?.set(company: company)
    }
    
    private func updateView() {
        view?.updateUI()
    }
}

extension DetailPresenter {
    func isAbleToManipulate() {
        setCompanyIntoView()
    }
    
    func switchFavorite() {
        if company.isFavorite {
            FavoritesManager.shared.remove(company)
        } else {
            FavoritesManager.shared.add(company)
        }
        
        updateView()
    }
    
}
