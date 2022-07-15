//
//  FavoritesPresenter.swift
//  StockMarket
//
//  Created by Александр Казак-Казакевич on 11.07.2022.
//

import Foundation

class FavoritesPresenter: CompaniesListPresenter {
    private(set) var companies: [Company] = []
    weak var view: SearchViewController?
    
    private(set) var viewTitle = "Favorites"
    
    init() {
        Task {
            await FavoritesManager.shared.refreshData()
            companies = FavoritesManager.shared.favorites
            
            DispatchQueue.main.async { [weak self] in
                self?.updateView()
            }
        }
    }
}

extension FavoritesPresenter {
    private func updateView() {
        view?.updateUI()
    }
}

extension FavoritesPresenter {
    func search(for ticker: String) {
        
    }
    
    func cancelSearch() {
        
    }
    
    
    
    func updateFavorites() {
        companies = FavoritesManager.shared.favorites
        updateView()
    }
}
