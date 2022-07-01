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
    }
    
    
    // MARK: Just for ensure that the TabBarController works
    func fillWithViewControllers() {
        
        var vcs: [UIViewController] = []
        
        for i in (0...3) {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(hue: (CGFloat(i) / 4), saturation: 1, brightness: 1, alpha: 1)
            vc.tabBarItem = UITabBarItem(title: String(i), image: UIImage(systemName: "\(i).circle"), selectedImage: nil)
            vcs.append(vc)
        }
        
        viewControllers = vcs
    }
}
