//
//  Appearance.swift
//  PetProject
//
//  Created by Andrew Sagatelov on 25.01.2024.
//

import UIKit
 func setAppearance() {
    if #available(iOS 15, *) {
        // MARK: Navigation bar appearance
        UINavigationBar.appearance().tintColor = .systemGray
        
        
        // MARK: Tab bar appearance
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = #colorLiteral(red: 0.3799754083, green: 0.3799754083, blue: 0.3799754083, alpha: 1)
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        UITabBar.appearance().standardAppearance = tabBarAppearance
    }
}
