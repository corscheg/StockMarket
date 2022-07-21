//
//  SearchPresenter.swift
//  StockMarket
//
//  Created by Александр Казак-Казакевич on 04.07.2022.
//

import Foundation

class SearchPresenter {
    private var task: Task<Void, Never>?
    
    weak var view: SearchViewController?
    
    private var resultTickers: [String] = []
    private(set) var companies: [Company] = []
    
    private(set) var viewTitle = "Search"
    
    private var needsAlert = true
}

extension SearchPresenter {
    private func updateView() {
        view?.updateUI()
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
        task?.cancel()
        task = nil
        companies = []
        updateView()
        startNetworkingIndication()
        needsAlert = true
        
        task = Task {
            do {
                resultTickers = try await SearchResultsFetcher.shared.fetchResults(for: ticker)
                
                if resultTickers.isEmpty {
                    DispatchQueue.main.async { [weak self] in
                        self?.updateViewNotFound()
                    }
                } else {
                    for resultTicker in resultTickers {
                        if let company = try? await CompanyFetcher.shared.fetchCompany(with: resultTicker), !companies.contains(company) {
                            
                            companies.append(company)
                            
                            DispatchQueue.main.async { [weak self] in
                                self?.updateView()
                            }
                        }
                    }
                    if companies.isEmpty && task != nil {
                        DispatchQueue.main.async { [weak self] in
                            self?.updateViewNotFound()
                        }
                    }
                }
                
                DispatchQueue.main.async { [weak self] in
                    self?.stopNetworkingIndication()
                }
            } catch {
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
        if task != nil {
            needsAlert = false
        }
        task?.cancel()
        task = nil
        companies = []
        updateView()
        stopNetworkingIndication()
    }
    
    func update() {
        updateView()
    }
}
