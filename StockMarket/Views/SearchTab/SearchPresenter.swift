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
    
    private func push(detailView: DetailViewController) {
        view?.push(detailView: detailView)
    }
}

extension SearchPresenter {
    func search(for ticker: String) {
        task?.cancel()
        task = nil
        companies = []
        updateView()
        startNetworkingIndication()
        
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
                // TODO: Replace debug print statement
                print(error)
            }
        }
    }
    
    func cancelSearch() {
        task?.cancel()
        task = nil
        companies = []
        updateView()
        stopNetworkingIndication()
    }
    
    func initiateDetail(at index: Int) {
        let presenter = DetailPresenter(company: companies[index])
        let vc = DetailViewController()
        
        vc.presenter = presenter
        presenter.view = vc
        
        push(detailView: vc)
    }
}
