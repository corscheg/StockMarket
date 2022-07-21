//
//  MoreViewController.swift
//  StockMarket
//
//  Created by Александр Казак-Казакевич on 18.07.2022.
//

import UIKit

/// A ViewController for the last tab.
class MoreViewController: UIViewController {
    
    private var tableView: UITableView!
    
    /// A presenter that provides data and methods.
    var presenter: MorePresenter!
    
    override func loadView() {
        tableView = UITableView()
        view = tableView
        view.backgroundColor = .systemGray6
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "More"
        
        presenter.view = self
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MoreCell")
    }
}

extension MoreViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            clearFavoritesTapped()
        default:
            break
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MoreCell", for: indexPath)
        var config = cell.defaultContentConfiguration()
        config.text = "Remove all favorites"
        cell.contentConfiguration = config
        return cell
    }
}

extension MoreViewController {
    
    /// Ask a user for confirmation and clear favorites.
    private func clearFavoritesTapped() {
        let ac = UIAlertController(title: "Remove all favorites?", message: "You are about to clear your favorite companies.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Remove", style: .destructive) { [weak self] _ in
            self?.clearFavorites()
        })
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
}

extension MoreViewController {
    
    /// Clear favorites.
    private func clearFavorites() {
        presenter.clearFavorites()
    }
}
