//
//  MorePresenter.swift
//  StockMarket
//
//  Created by Александр Казак-Казакевич on 18.07.2022.
//

import Foundation

/// A presenter that provides data and methods for the More tab.
class MorePresenter {
    
    /// A view drawing data.
    weak var view: MoreViewController?
}

extension MorePresenter {
    
    /// Clears favorites.
    func clearFavorites() {
        FavoritesManager.shared.clearAll()
    }
}
