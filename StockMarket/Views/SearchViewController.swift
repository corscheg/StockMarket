//
//  SearchViewController.swift
//  StockMarket
//
//  Created by Александр Казак-Казакевич on 04.07.2022.
//

import UIKit

class SearchViewController: UIViewController {
    
    var searchBar: UISearchBar!
    var sharesList: UITableView!
    
    override func loadView() {
        super.loadView()
        
        sharesList = UITableView()
        view = sharesList
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray6

        navigationItem.title = "Search"
        navigationItem.searchController = UISearchController(searchResultsController: nil)
        
        Task {
            do {
                let share = try await ShareFetcher().fetchShare(withTicker: "AAPL")
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
