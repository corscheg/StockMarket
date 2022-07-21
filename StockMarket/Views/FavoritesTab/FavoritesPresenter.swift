//
//  FavoritesPresenter.swift
//  StockMarket
//
//  Created by Александр Казак-Казакевич on 11.07.2022.
//

import Foundation

/// A class that provides data and methods for Favorites tab.
class FavoritesPresenter: CompaniesListPresenter {
    
    private(set) var companies: [Company] = []
    
    /// An array of all favorite companies.
    private var unfilteredCompanies: [Company] = []
    weak var view: SearchViewController?
    
    private(set) var viewTitle = "Favorites"
    
    /// Initializer refreshes data if possible, fills `companies` and updates view.
    init() {
        Task {
            
            // Refresh data and set properties
            await FavoritesManager.shared.refreshData()
            unfilteredCompanies = FavoritesManager.shared.favorites
            companies = unfilteredCompanies
            
            // Update view on the main thread
            DispatchQueue.main.async { [weak self] in
                self?.updateView()
            }
        }
    }
}

extension FavoritesPresenter {
    
    /// Update the view.
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
    
    func update() {
        unfilteredCompanies = FavoritesManager.shared.favorites
        companies = unfilteredCompanies
        updateView()
    }
}
