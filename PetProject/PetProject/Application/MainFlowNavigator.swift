//
//  MainNavigator.swift
//  PetProject
//
//  Created by Andrew Sagatelov on 05.12.2023.
//

import Foundation
import UIKit

protocol InitialVCForFlowNavigatorProtocol{
    func initController() -> UIViewController
}

protocol MainFlowNavigatorProtocol {
    init(window: UIWindow)
    var tabBar: UITabBarController { get }
    var screenBuilder: ScreenBuilderProtocol { get }
    var navigators: [InitialVCForFlowNavigatorProtocol] { get }
    
}

final class MainFlowNavigator: MainFlowNavigatorProtocol {
    
    
    private var window: UIWindow
    var tabBar: UITabBarController
    var navigators: [InitialVCForFlowNavigatorProtocol] = []
    var screenBuilder: ScreenBuilderProtocol
    
    
    
    required init(window: UIWindow) {
        self.window = window
        self.tabBar = UITabBarController()
        self.screenBuilder = ScreenBuilder()
        navigators = [UsersFlowCoordinator(screenBuilder: screenBuilder)]
        let controllers = navigators.map { $0.initController() }
        tabBar.viewControllers = controllers
        window.rootViewController = tabBar
    }
}

