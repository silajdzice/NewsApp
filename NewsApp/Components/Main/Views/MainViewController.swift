//
//  MainViewController.swift
//  NewsApp
//
//  Created by Edhem Silajdzic on 29/08/2020.
//  Copyright © 2020 Edhem Silajdzic. All rights reserved.
//

import Foundation
import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    private func setupTabBar() {
        self.viewControllers = [newsTabBar, historyTabBar]
        tabBar.barTintColor = UIColor(named: "tabBarColor")
        tabBar.tintColor = .white
        tabBar.isTranslucent = false
    }
    
    lazy public var newsTabBar: NewsViewController = {
        
        let storyboard = UIStoryboard.newsStoryboard()
        let newsTabBar: NewsViewController = storyboard.instantiateViewController(identifier: "NewsViewController")
        
        let tabBarItems = (title: Constants.News, image: #imageLiteral(resourceName: "newsTabBar"), selectedImage: #imageLiteral(resourceName: "newsTabBarSelected"))
        let tabBarItem = UITabBarItem(title: tabBarItems.title, image: tabBarItems.image, selectedImage: tabBarItems.selectedImage)
        newsTabBar.tabBarItem = tabBarItem

        return newsTabBar
    }()
    
    lazy public var historyTabBar: HistoryViewController = {
        
        let storyboard = UIStoryboard.historyStoryboard()
        let historyTabBar: HistoryViewController = storyboard.instantiateViewController(identifier: "HistoryViewController")
        
        let tabBarItems = (title: Constants.MyHistory, image: #imageLiteral(resourceName: "myHistoryTabBar"), selectedImage: #imageLiteral(resourceName: "myHistoryTabBarSelected"))
        let tabBarItem = UITabBarItem(title: tabBarItems.title, image: tabBarItems.image, selectedImage: tabBarItems.selectedImage)
        historyTabBar.tabBarItem = tabBarItem

        return historyTabBar
    }()
    
}

extension MainViewController: UITabBarControllerDelegate {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
    }
}
