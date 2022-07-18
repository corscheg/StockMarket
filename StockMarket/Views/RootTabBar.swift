//
//  RootTabBar.swift
//  StockMarket
//
//  Created by Александр Казак-Казакевич on 01.07.2022.
//

import UIKit

class RootTabBar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fillWithViewControllers()
        tabBar.backgroundColor = .lightGray
        tabBar.alpha = 0.5
    }
    
    
    // MARK: Just for ensure that the TabBarController works. To be filled with real ViewControllers later on.
    func fillWithViewControllers() {
        
        var vcs: [UIViewController] = []
        
        let vc0 = UIViewController()
        vc0.view.backgroundColor = .systemRed
        vc0.tabBarItem = UITabBarItem(tabBarSystemItem: .topRated, tag: 0)
        vcs.append(vc0)
        
        let fvc = SearchViewController()
        fvc.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        fvc.presenter = FavoritesPresenter()
        let fnc = UINavigationController(rootViewController: fvc)
        fnc.navigationBar.prefersLargeTitles = true
        vcs.append(fnc)
        
        let svc = SearchViewController()
        svc.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 2)
        svc.presenter = SearchPresenter()
        let snc = UINavigationController(rootViewController: svc)
        snc.navigationBar.prefersLargeTitles = true
        vcs.append(snc)
        
        let mvc = MoreViewController()
        mvc.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 3)
        mvc.presenter = MorePresenter()
        let mnc = UINavigationController(rootViewController: mvc)
        mnc.navigationBar.prefersLargeTitles = true
        vcs.append(mnc)
        
        viewControllers = vcs
    }
}
