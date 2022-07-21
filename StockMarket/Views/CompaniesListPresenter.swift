//
//  CompaniesListPresenter.swift
//  StockMarket
//
//  Created by Александр Казак-Казакевич on 11.07.2022.
//

import Foundation

/// A set of rules that are used by ViewControllers that manage lists of companies.
protocol CompaniesListPresenter {
    
    /// An array of companies that are used by table view datasource.
    var companies: [Company] { get }
    
    /// A reference to a ViewController.
    var view: SearchViewController? { get set }
    
    /// A title for the page.
    var viewTitle: String { get }
    
    /// Searches for a certain company in the list by ticker.
    func search(for ticker: String)
    
    /// Stops the search.
    func cancelSearch()
    
    /// Builds a DetailViewController.
    func initiateDetail(at index: Int)
    
    /// Updates the underlying data.
    func update()
    
    /// Pushes a DetailViewController.
    func push(detailView: DetailViewController)
}

extension CompaniesListPresenter {
    internal func push(detailView: DetailViewController) {
        view?.push(detailView: detailView)
    }
    
    func initiateDetail(at index: Int) {
        
        // Initialize a presenter
        let presenter = DetailPresenter(company: companies[index])
        
        // Initialize a ViewController
        let vc = DetailViewController()
        
        // Assemble
        vc.presenter = presenter
        presenter.view = vc
        
        push(detailView: vc)
    }
}
