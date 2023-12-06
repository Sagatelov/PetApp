//
//  MainNavigator.swift
//  PetProject
//
//  Created by Andrew Sagatelov on 05.12.2023.
//

import Foundation
import UIKit

protocol InitControllerForFlowNavigatorProtocol{
    func initController() -> ViewController
}

protocol MainFlowNavigatorProtocol {
    init(window: UIWindow)
    var tabBar: UITabBarController { get set}
    var screenBuilder: ScreenBuilderProtocol { get set }
}

final class MainFlowNavigator: MainFlowNavigatorProtocol {
    
    
    private var window: UIWindow
    var tabBar: UITabBarController
    var navigators: [InitControllerForFlowNavigatorProtocol] = []
    var screenBuilder: ScreenBuilderProtocol
    
    
    
    required init(window: UIWindow) {
        self.window = window
        self.tabBar = UITabBarController()
        self.screenBuilder = ScreenBuilder()
        navigators = [UsersFlowCoordinator()]
        var controllers = navigators.map { $0.initController() }
        tabBar.viewControllers = controllers
    }
}

