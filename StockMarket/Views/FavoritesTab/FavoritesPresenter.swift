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
        companies = FavoritesManager.shared.favorites
        updateView()
    }
}

extension FavoritesPresenter {
    func push(detailView: DetailViewController) {
        view?.push(detailView: detailView)
    }
    
    func updateView() {
        view?.updateUI()
    }
}

extension FavoritesPresenter {
    func search(for ticker: String) {
        
    }
    
    func cancelSearch() {
        
    }
    
    func initiateDetail(at index: Int) {
        let presenter = DetailPresenter(company: companies[index])
        let vc = DetailViewController()
        
        vc.presenter = presenter
        presenter.view = vc
        
        push(detailView: vc)
    }
    
    func updateFavorites() {
        companies = FavoritesManager.shared.favorites
        updateView()
    }
}
