//
//  SearchViewController.swift
//  StockMarket
//
//  Created by Александр Казак-Казакевич on 04.07.2022.
//

import UIKit

class SearchViewController: UIViewController {
    
    enum SearchState {
        case prompt, found, notFound
    }
    
    var searchBar: UISearchBar!
    var resultView: UIView!
    
    var state: SearchState = .prompt
    
    override func loadView() {
        super.loadView()
        
        resultView = SearchPromptView()
        view.addSubview(resultView)
        
        resultView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        resultView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        resultView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        resultView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray6

        navigationItem.title = "Search"
        navigationItem.searchController = UISearchController(searchResultsController: nil)
        
    }
    
    func updateUI() {
        switch state {
        case .prompt:
            resultView = SearchPromptView()
        case .found:
            fallthrough
        case .notFound:
            break
        }
    }
}
