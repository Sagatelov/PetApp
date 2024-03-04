//
//  ProfileFlowCoordinator.swift
//  PetProject
//
//  Created by Andrew Sagatelov on 11.02.2024.
//

import UIKit

protocol ProfileFlowProtocol: MainCoordinatorProtocol {
    func favoritesScreen()
}

typealias ProfileCoordinatorConfig = ProfileFlowProtocol & InitialVCForFlowNavigatorProtocol

final class ProfileFlowCoordinator: ProfileCoordinatorConfig {
    
    var navigation: UINavigationController
    var screenBuilder: ScreenBuilderProtocol
    
    init(screenBuilder: ScreenBuilderProtocol) {
        self.screenBuilder = screenBuilder
        navigation = UINavigationController()
    }
    
    func favoritesScreen() {
        let screen = screenBuilder.favoritesScreen(coordinator: self)
        navigation.pushViewController(screen, animated: true)
    }
    
    ///return initial view controller for MainFlowNavigator
    func initController() -> UIViewController {
        let profile = screenBuilder.profileScreen(coordinator: self)
        navigation.setViewControllers([profile], animated: true)
        return navigation
    }
}
