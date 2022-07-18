//
//  FavoritesPresenter.swift
//  StockMarket
//
//  Created by Александр Казак-Казакевич on 11.07.2022.
//

import Foundation

class FavoritesPresenter: CompaniesListPresenter {
    private(set) var companies: [Company] = []
    private var unfilteredCompanies: [Company] = []
    weak var view: SearchViewController?
    
    private(set) var viewTitle = "Favorites"
    
    init() {
        Task {
            await FavoritesManager.shared.refreshData()
            unfilteredCompanies = FavoritesManager.shared.favorites
            companies = unfilteredCompanies
            
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
        companies = unfilteredCompanies.filter { $0.name.lowercased().contains(ticker.lowercased()) || $0.ticker.lowercased().contains(ticker.lowercased()) }
        updateView()
    }
    
    func cancelSearch() {
        companies = unfilteredCompanies
        updateView()
    }
    
    func updateFavorites() {
        unfilteredCompanies = FavoritesManager.shared.favorites
        companies = unfilteredCompanies
        updateView()
    }
}
