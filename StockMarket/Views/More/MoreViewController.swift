//
//  MoreViewController.swift
//  StockMarket
//
//  Created by Александр Казак-Казакевич on 18.07.2022.
//

import UIKit

class MoreViewController: UIViewController {
    
    var tableView: UITableView!
    
    var presenter: MorePresenter!
    
    override func loadView() {
        tableView = UITableView()
        view = tableView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "More"
        
        presenter.view = self
    }
}

extension MoreViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
