//
//  SearchViewController.swift
//  StockMarket
//
//  Created by Александр Казак-Казакевич on 04.07.2022.
//

import UIKit

class SearchViewController: UIViewController {
    
    var presenter = SearchPresenter()
    
    override func loadView() {
        view = UIView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray6
        presenter.view = self

        navigationItem.title = "Search"
        navigationItem.searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController?.searchBar.delegate = self
        
    }
    
    func updateUI(with state: SearchState) {
        
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        presenter.search(for: navigationItem.searchController?.searchBar.text ?? "")
    }
}
