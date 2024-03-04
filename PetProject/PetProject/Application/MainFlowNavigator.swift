//
//  MainNavigator.swift
//  PetProject
//
//  Created by Andrew Sagatelov on 05.12.2023.
//

import Foundation
import UIKit

protocol InitialVCForFlowNavigatorProtocol {
    func initController() -> UIViewController
}

protocol MainFlowNavigatorProtocol {
    init(window: UIWindow)
    var tabBar: UITabBarController { get }
    var navigators: [InitialVCForFlowNavigatorProtocol] { get }
    var registration: InitialVCForFlowNavigatorProtocol { get }
    var screenBuilder: ScreenBuilderProtocol { get }
}

final class MainFlowNavigator: MainFlowNavigatorProtocol {
    
    
    private var window: UIWindow
    var tabBar: UITabBarController
    var navigators: [InitialVCForFlowNavigatorProtocol]
    var registration: InitialVCForFlowNavigatorProtocol
    var screenBuilder: ScreenBuilderProtocol
    
    //MARK: services
    var network: NetworkServiceProtocol
    var coreDataStorage: CoreDataStorage
    var authManager: AuthManagerProtocol
    
    required init(window: UIWindow) {
        //init services
        network = NetworkService()
        coreDataStorage = CoreDataStorage.sared
        authManager = AuthManager()
        
        //init builder screen
        screenBuilder = ScreenBuilder(network: network,
                                      coreDataStorage: coreDataStorage,
                                      authManager: authManager)
        //Coordinators
        navigators = [UsersFlowCoordinator(screenBuilder: screenBuilder),
                      ProfileFlowCoordinator(screenBuilder: screenBuilder)]
        
        registration = RegFlowCoordinator(screenBuilder: screenBuilder)
        
        //MARK: Root controllers
        let controllers = navigators.map { $0.initController() }
        let registration = registration.initController()
        registration.modalPresentationStyle = .fullScreen
        registration.modalTransitionStyle = .crossDissolve
        
        tabBar = UITabBarController()
        tabBar.setViewControllers(controllers, animated: true)
        
        self.window = window
        window.rootViewController = tabBar
        tabBar.present(registration, animated: false)
    }
}

