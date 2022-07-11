//
//  CompaniesListPresenter.swift
//  StockMarket
//
//  Created by Александр Казак-Казакевич on 11.07.2022.
//

import Foundation

protocol CompaniesListPresenter {
    var companies: [Company] { get }
    var view: SearchViewController? { get set }
    var viewTitle: String { get }
    
    func search(for ticker: String)
    func cancelSearch()
    func initiateDetail(at index: Int)
    func updateFavorites()
}
