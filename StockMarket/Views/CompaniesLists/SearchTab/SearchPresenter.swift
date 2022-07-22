//
//  SearchPresenter.swift
//  StockMarket
//
//  Created by Александр Казак-Казакевич on 04.07.2022.
//

import Foundation

/// A class that provides a data and methods for the Search tab.
class SearchPresenter {
    
    /// A task used for networking.
    private var task: Task<Void, Never>?
    
    weak var view: CompaniesListViewController?

    private(set) var companies: [Company] = []
    
    private(set) var viewTitle = "Search"
    
    /// A bool storing whether an error message should be presented in the case of networking error.
    private var needsAlert = true
}

extension SearchPresenter {
    private func updateView() {
        view?.updateUI()
    }
    
    private func reloadView() {
        view?.reloadUI()
    }
    
    private func updateViewNotFound() {
        view?.updateNotFound()
    }
    
    private func startNetworkingIndication() {
        view?.startNetworkingIndication()
    }
    
    private func stopNetworkingIndication() {
        view?.stopNetworkingIndication()
    }
    
    private func showErrorAlert(with message: String) {
        view?.showErrorAlert(with: message)
    }
}

extension SearchPresenter: CompaniesListPresenter {
    func search(for ticker: String) {
        
        // Cancel existing task
        task?.cancel()
        task = nil
        companies = []
        
        // Set the view to the proper state
        updateView()
        startNetworkingIndication()
        
        // Alert is needed
        needsAlert = true
        
        task = Task {
            do {
                
                // Fetch tickers by query
                let resultTickers = try await SearchResultsFetcher.shared.fetchResults(for: ticker)
                
                // If there is no results -- update the view
                if resultTickers.isEmpty {
                    DispatchQueue.main.async { [weak self] in
                        self?.updateViewNotFound()
                    }
                } else {
                    
                    // There are some results -- loop through them
                    for resultTicker in resultTickers {
                        
                        // Fetch a company by ticker
                        if let company = try? await CompanyFetcher.shared.fetchCompany(with: resultTicker), !companies.contains(company) {
                            
                            // Append to the list
                            companies.append(company)
                            
                            // And update the view
                            DispatchQueue.main.async { [weak self] in
                                self?.updateView()
                            }
                        }
                    }
                    
                    // If no companies found by tickers, set view to the NotFound state
                    if companies.isEmpty && task != nil {
                        DispatchQueue.main.async { [weak self] in
                            self?.updateViewNotFound()
                        }
                    }
                }
                
                // Networking finished -- stop indication
                DispatchQueue.main.async { [weak self] in
                    self?.stopNetworkingIndication()
                }
            } catch {
                
                // Show the error if needed
                if needsAlert {
                    DispatchQueue.main.async { [weak self] in
                        self?.showErrorAlert(with: error.localizedDescription)
                        self?.stopNetworkingIndication()
                    }
                }
            }
        }
    }
    
    func cancelSearch() {
        
        // If there is a present task -- no error displaying needed (task interrupted by the user)
        if task != nil {
            needsAlert = false
            
            // Make the list empty
            companies = []
            
            // Update UI
            updateView()
            stopNetworkingIndication()
            
            // Cancel the task
            task?.cancel()
            task = nil
        }
    }
    
    func reload() {
        reloadView()
    }
}
