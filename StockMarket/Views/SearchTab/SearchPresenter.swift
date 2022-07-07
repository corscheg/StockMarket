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
        updateView()
        
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
                
            } catch {
                print(error)
            }
        }
    }
    
    private func updateView() {
        view?.updateUI()
    }
}
