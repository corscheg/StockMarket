//
//  NewsViewController.swift
//  StockMarket
//
//  Created by Александр Казак-Казакевич on 22.07.2022.
//

import UIKit

/// A class for displaying the latest news.
class NewsViewController: UIViewController {
    
    /// A reference to the presenter.
    var presenter: NewsPresenter!
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .systemGray6
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "News"
    }

}
