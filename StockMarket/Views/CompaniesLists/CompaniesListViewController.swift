//
//  SearchViewController.swift
//  StockMarket
//
//  Created by Александр Казак-Казакевич on 04.07.2022.
//

import UIKit

/// A ViewController responsible for lists of companies.
class CompaniesListViewController: UIViewController {
    
    /// A presenter of data.
    var presenter: CompaniesListPresenter!
    
    private var tableView: UITableView!
    
    /// A view used for displaying of networking process.
    private var indicatorView: UIActivityIndicatorView!
    
    /// A view used for indicating of empty search results.
    private var notFoundView: UIStackView!
    private var noResults: UILabel!
    private var tryAnother: UILabel!
    
    
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
        tableView.register(CompaniesListTableViewCell.self, forCellReuseIdentifier: "Result")
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        askForUpdate()
    }
}

extension CompaniesListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        search(for: navigationItem.searchController?.searchBar.text ?? "")
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        tableView.isHidden = false
        notFoundView.isHidden = true
        cancelSearch()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            tableView.isHidden = false
            notFoundView.isHidden = true
            cancelSearch()
        }
    }
    
}

extension CompaniesListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfCompanies()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Result")! as! CompaniesListTableViewCell
        cell.configure(for: company(forIndex: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        openDetail(at: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension CompaniesListViewController {
    
    /// Provide a company for a certain index in the list.
    private func company(forIndex index: Int) -> Company {
        presenter.companies[index]
    }
    
    /// Returns number of companies in the list.
    private func numberOfCompanies() -> Int {
        presenter.companies.count
    }
    
    private func search(for query: String) {
        presenter.search(for: query)
    }
    
    private func cancelSearch() {
        presenter.cancelSearch()
    }
    
    /// Ask presenter for pushing the detail view.
    private func openDetail(at index: Int) {
        presenter.initiateDetail(at: index)
    }
    
    /// Ask presenter for data refreshing.
    private func askForUpdate() {
        presenter.reload()
    }
}

extension CompaniesListViewController {
    
    /// Refresh the view's state.
    func updateUI() {
        if numberOfCompanies() == 0 {
            tableView.reloadSections(IndexSet(integer: 0), with: .fade)
        } else {
            tableView.insertRows(at: [IndexPath(row: numberOfCompanies() - 1, section: 0)], with: .left)
        }
    }
    
    func reloadUI() {
        tableView.reloadSections(IndexSet(integer: 0), with: .fade)
    }
    
    func startNetworkingIndication() {
        indicatorView.startAnimating()
        notFoundView.isHidden = true
        tableView.isHidden = false
    }
    
    func stopNetworkingIndication() {
        indicatorView.stopAnimating()
    }
    
    /// Set the view's state to the one representing that there is not any matching companies.
    func updateNotFound() {
        notFoundView.isHidden = false
        tableView.isHidden = true
    }
    
    /// Push the given `DetailViewController`.
    func push(detailView view: DetailViewController) {
        navigationController?.pushViewController(view, animated: true)
    }
    
    /// Indicate that there is some error.
    func showErrorAlert(with message: String) {
        let ac = UIAlertController(title: "Networking error", message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    /// Clears the Search Bar.
    func clearSearchQuery() {
        navigationItem.searchController?.searchBar.text = ""
    }
}
