//
//  MorePresenter.swift
//  StockMarket
//
//  Created by Александр Казак-Казакевич on 18.07.2022.
//

import Foundation

class MorePresenter {
    weak var view: MoreViewController?
}

extension MorePresenter {
    func clearFavorites() {
        FavoritesManager.shared.clearAll()
    }
}
