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
    
    var results: [Company] = []
    
    var names: [String] {
        var names = [String]()
        for result in results {
            names.append(result.name)
        }
        return names
    }
    
    
    
    func search(for ticker: String) {
        task?.cancel()
        task = nil
        updateView()
        
        task = Task {
            do {
                results = try await SearchResultsFetcher.shared.fetchResults(for: ticker)
            } catch {
                print(error)
            }
            DispatchQueue.main.async { [weak self] in
                self?.updateView()
            }
        }
    }
    
    private func updateView() {
        view?.updateNames(names)
        view?.updateUI()
    }
}
