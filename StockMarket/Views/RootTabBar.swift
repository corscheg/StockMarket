//
//  RootTabBar.swift
//  StockMarket
//
//  Created by Александр Казак-Казакевич on 01.07.2022.
//

import UIKit

/// A TabBar that is used as a root ViewController of the App.
class RootTabBar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fillWithViewControllers()
        tabBar.backgroundColor = .lightGray
        tabBar.alpha = 0.5
    }
    
    
    // MARK: Just for ensure that the TabBarController works. To be filled with real ViewControllers later on.
    
    /// Initiates a proper ViewControllers and filles the `viewControllers` property with them.
    private func fillWithViewControllers() {
        
        var vcs: [UIViewController] = []
        
        let nvc = NewsViewController()
        nvc.tabBarItem = UITabBarItem(title: "News", image: UIImage(systemName: "newspaper"), tag: 0)
        nvc.presenter = NewsPresenter()
        let nnc = UINavigationController(rootViewController: nvc)
        nnc.navigationBar.prefersLargeTitles = true
        vcs.append(nnc)
        
        // Initialize and append a Favorites Tab
        let fvc = CompaniesListViewController()
        fvc.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        fvc.presenter = FavoritesPresenter()
        let fnc = UINavigationController(rootViewController: fvc)
        fnc.navigationBar.prefersLargeTitles = true
        vcs.append(fnc)
        
        // Initialize and append a Search Tab
        let svc = CompaniesListViewController()
        svc.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 2)
        svc.presenter = SearchPresenter()
        let snc = UINavigationController(rootViewController: svc)
        snc.navigationBar.prefersLargeTitles = true
        vcs.append(snc)
        
        // Initialize and append a More Tab
        let mvc = MoreViewController()
        mvc.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 3)
        mvc.presenter = MorePresenter()
        let mnc = UINavigationController(rootViewController: mvc)
        mnc.navigationBar.prefersLargeTitles = true
        vcs.append(mnc)
        
        // Set the TabBar's property to the assembled ViewControllers
        viewControllers = vcs
    }
}
