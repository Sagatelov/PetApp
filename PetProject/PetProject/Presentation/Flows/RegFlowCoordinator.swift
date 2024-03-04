//
//  RegFlowCoordinator.swift
//  PetProject
//
//  Created by Andrew Sagatelov on 11.02.2024.
//

import UIKit

protocol RegistrationProtocol: MainCoordinatorProtocol {
    func signUpScreen()
    func loginScreen()
}

typealias RegistrationCoordinatorConfig = RegistrationProtocol & InitialVCForFlowNavigatorProtocol

final class RegFlowCoordinator: RegistrationCoordinatorConfig {
    
    var navigation: UINavigationController
    var screenBuilder: ScreenBuilderProtocol
    
    init(screenBuilder: ScreenBuilderProtocol) {
        self.screenBuilder = screenBuilder
        navigation = UINavigationController()
    }
    
    ///return initial view controller for MainFlowNavigator
    func initController() -> UIViewController {
        let screen = screenBuilder.welcomeScreen(coordinator: self)
        navigation.pushViewController(screen, animated: true)
        return navigation
    }
    
    func signUpScreen() {
        let screen = screenBuilder.signUpScreen(coordinator: self)
        navigation.pushViewController(screen, animated: true)
    }
    
    func loginScreen() {
        let screen = screenBuilder.loginScreen(coordinator: self)
        navigation.pushViewController(screen, animated: true)
    }
}
