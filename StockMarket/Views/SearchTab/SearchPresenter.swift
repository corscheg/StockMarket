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
    
    weak var view: SearchViewController!
    
    var result: Share?
    
    func search(for ticker: String) {
        task?.cancel()
        task = nil
        state = .inProgress
        updateView()
        
        task = Task {
            do {
                result = try await ShareFetcher.shared.fetchShare(withTicker: ticker)
                state = .found
            } catch {
                state = .notFound
                print(error.localizedDescription)
            }
            DispatchQueue.main.async { [weak self] in
                self?.updateView()
            }
        }
    }
    
    func updateView() {
        view.updateUI(with: state)
    }
}
