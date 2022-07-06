//
//  SearchViewController.swift
//  StockMarket
//
//  Created by Александр Казак-Казакевич on 04.07.2022.
//

import UIKit

class SearchViewController: UIViewController {
    
    var presenter = SearchPresenter()
    
    var searchBar: UISearchBar!
    var resultView: UIView! {
        
        didSet {
            view.addSubview(resultView)
            resultView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
            resultView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
            resultView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
            resultView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        }
    }
    
    override func loadView() {
        view = UIView()
        resultView = SearchPromptView()
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
        switch state {
        case .prompt:
            resultView = SearchPromptView()
        case .found(let name):
            resultView = SearchFoundView(name: name)
        case .notFound:
            resultView = SearchNotFoundView()
        case .inProgress:
            resultView = SearchInProgressView()
        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        presenter.search(for: navigationItem.searchController?.searchBar.text ?? "")
    }
}
