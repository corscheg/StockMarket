//
//  SearchPresenter.swift
//  StockMarket
//
//  Created by Александр Казак-Казакевич on 04.07.2022.
//

import Foundation

class SearchPresenter {
    var task: Task<Void, Never>?
    
    weak var view: SearchViewController?
    
    var resultTickers: [String] = []
    var companies: [Company] = []    
    
    func search(for ticker: String) {
        task?.cancel()
        task = nil
        companies = []
        updateView()
        startNetworkingIndication()
        
        task = Task {
            do {
                resultTickers = try await SearchResultsFetcher.shared.fetchResults(for: ticker)
                
                for resultTicker in resultTickers {
                    if let company = try? await CompanyFetcher.shared.fetchCompany(with: resultTicker), !companies.contains(company) {
                        
                        companies.append(company)
                        
                        DispatchQueue.main.async { [weak self] in
                            self?.updateView()
                        }
                    }
                }
                
                DispatchQueue.main.async { [weak self] in
                    self?.stopNetworkingIndication()
                }
            } catch {
                // TODO: Replace debug print statement
                print(error)
            }
        }
    }
    
    private func updateView() {
        view?.updateUI()
    }
    
    private func startNetworkingIndication() {
        view?.startNetworkingIndication()
    }
    
    private func stopNetworkingIndication() {
        view?.stopNetworkingIndication()
    }
}
