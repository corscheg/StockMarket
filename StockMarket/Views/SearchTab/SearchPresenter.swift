//
//  SearchPresenter.swift
//  StockMarket
//
//  Created by Александр Казак-Казакевич on 04.07.2022.
//

import Foundation

class SearchPresenter {
    var state: SearchState = .prompt
    var task: Task<Void, Never>?
    
    weak var view: SearchViewController?
    
    var result: Company?
    
    
    
    func search(for ticker: String) {
        task?.cancel()
        task = nil
        state = .inProgress
        updateView()
        
        task = Task {
            do {
                result = try await CompanyFetcher.shared.fetchCompany(with: ticker)
                state = .found(name: result?.name ?? "Fetching company issues...")
            } catch {
                state = .notFound
                print(error)
            }
            DispatchQueue.main.async { [weak self] in
                self?.updateView()
            }
        }
    }
    
    func updateView() {
        view?.updateUI(with: state)
    }
}
