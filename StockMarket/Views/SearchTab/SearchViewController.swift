//
//  SearchViewController.swift
//  StockMarket
//
//  Created by Александр Казак-Казакевич on 04.07.2022.
//

import UIKit

class SearchViewController: UIViewController {
    
    var presenter: CompaniesListPresenter!
    
    var tableView: UITableView!
    var indicatorView: UIActivityIndicatorView!
    
    var notFoundView: UIStackView!
    var noResults: UILabel!
    var tryAnother: UILabel!
    
    
    override func loadView() {
        view = UIView()
        
        navigationItem.searchController = UISearchController(searchResultsController: nil)
        
        tableView = UITableView(frame: view.bounds, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemGray6
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50.0
        view.addSubview(tableView)
        
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        notFoundView = UIStackView()
        notFoundView.translatesAutoresizingMaskIntoConstraints = false
        notFoundView.axis = .vertical
        notFoundView.alignment = .center
        notFoundView.distribution = .equalSpacing
        notFoundView.spacing = 7
        notFoundView.isHidden = true
        view.addSubview(notFoundView)
        
        noResults = UILabel()
        noResults.translatesAutoresizingMaskIntoConstraints = false
        noResults.font = .preferredFont(forTextStyle: .largeTitle)
        noResults.numberOfLines = 1
        noResults.textAlignment = .center
        noResults.text = "No Results"
        notFoundView.addArrangedSubview(noResults)
        
        tryAnother = UILabel()
        tryAnother.translatesAutoresizingMaskIntoConstraints = false
        tryAnother.font = .preferredFont(forTextStyle: .subheadline)
        tryAnother.numberOfLines = 1
        tryAnother.textAlignment = .center
        tryAnother.text = "Try a new search."
        notFoundView.addArrangedSubview(tryAnother)
        
        notFoundView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        notFoundView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
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
        
        navigationItem.title = presenter.viewTitle
        
        navigationItem.searchController?.searchBar.delegate = self
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: "Result")
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = true
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

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        openDetail(at: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
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
    
    private func openDetail(at index: Int) {
        presenter.initiateDetail(at: index)
    }
}

extension SearchViewController {
    func updateUI() {
        tableView.reloadData()
    }
    
    func startNetworkingIndication() {
        indicatorView.startAnimating()
        notFoundView.isHidden = true
        tableView.isHidden = false
    }
    
    func stopNetworkingIndication() {
        indicatorView.stopAnimating()
    }
    
    func updateNotFound() {
        notFoundView.isHidden = false
        tableView.isHidden = true
    }
    
    func push(detailView view: DetailViewController) {
        navigationController?.pushViewController(view, animated: true)
    }
    
}
