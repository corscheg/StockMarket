//
//  SearchViewController.swift
//  StockMarket
//
//  Created by Александр Казак-Казакевич on 04.07.2022.
//

import UIKit

class SearchViewController: UIViewController {
    
    var presenter = SearchPresenter()
    
    var tableView: UITableView!
    var indicatorView: UIActivityIndicatorView!
    
    override func loadView() {
        view = UIView()
        
        navigationItem.title = "Search"
        navigationItem.searchController = UISearchController(searchResultsController: nil)
        
        
        tableView = UITableView(frame: view.bounds)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        indicatorView = UIActivityIndicatorView()
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        navigationItem.searchController?.searchBar.addSubview(indicatorView)
        
        if let searchController = navigationItem.searchController {
            indicatorView.centerYAnchor.constraint(equalTo: searchController.searchBar.centerYAnchor).isActive = true
            indicatorView.rightAnchor.constraint(equalTo: searchController.searchBar.rightAnchor, constant: -117).isActive = true
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray6
        presenter.view = self
        navigationItem.searchController?.searchBar.delegate = self
        
        tableView.dataSource = self
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: "Result")
        
        
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        search(for: navigationItem.searchController?.searchBar.text ?? "")
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        cancelSearch()
    }
}

extension SearchViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfCompanies()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Result")! as! SearchTableViewCell
        cell.configure(for: company(forIndex: indexPath.row))
        return cell
    }
}

extension SearchViewController {
    private func company(forIndex index: Int) -> Company {
        presenter.companies[index]
    }
    
    private func numberOfCompanies() -> Int {
        presenter.companies.count
    }
    
    private func search(for query: String) {
        presenter.search(for: query)
    }
    
    private func cancelSearch() {
        presenter.cancelSearch()
    }
}

extension SearchViewController {
    func updateUI() {
        tableView.reloadData()
    }
    
    func startNetworkingIndication() {
        indicatorView.startAnimating()
    }
    
    func stopNetworkingIndication() {
        indicatorView.stopAnimating()
    }
}
