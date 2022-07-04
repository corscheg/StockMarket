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
        
        let svc = SearchViewController()
        svc.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        let snc = UINavigationController(rootViewController: svc)
        snc.navigationBar.prefersLargeTitles = true
        vcs.append(snc)
        
        for i in (0...2) {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(hue: (CGFloat(i) / 4), saturation: 1, brightness: 1, alpha: 1)
            vc.tabBarItem = UITabBarItem(title: String(i), image: UIImage(systemName: "\(i).circle"), selectedImage: nil)
            vcs.append(vc)
        }
        
        viewControllers = vcs
    }
}
