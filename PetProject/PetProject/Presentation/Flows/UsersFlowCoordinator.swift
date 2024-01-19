//
//  UsersFlowNavigator.swift
//  PetProject
//
//  Created by Andrew Sagatelov on 06.12.2023.
//

import Foundation
import UIKit

protocol MainFlowCoordinatorProtocol {
    var navigation: UINavigationController { get }
    var screenBuilder: ScreenBuilderProtocol { get }
}

protocol FlowUsersProtocol: MainFlowCoordinatorProtocol {
    func edit(user: UsersModel)
    func showComments()
    func showPosts()
    func popToRoot()
}

typealias CoordinatorConfigProtocol = FlowUsersProtocol & InitialVCForFlowNavigatorProtocol

final class UsersFlowCoordinator: CoordinatorConfigProtocol {

    var navigation: UINavigationController
    var screenBuilder: ScreenBuilderProtocol
    
    init(screenBuilder: ScreenBuilderProtocol) {
        self.screenBuilder = screenBuilder
        navigation = UINavigationController()
    }
    
    func edit(user: UsersModel) {
        let userEdite = screenBuilder.showEditUserController(user: user, coordinator: self)
        navigation.pushViewController(userEdite, animated: true)
    }
    
    
    func showComments() {
    }
    
    func showPosts() {
    }
    
    func popToRoot() {
    }
    
    
    
    ///return initial view controller for MainFlowNavigator
    func initController() -> UIViewController {
        let usersList = screenBuilder.initialUserController(coordinator: self)
        navigation.viewControllers = [usersList]
        return navigation
    }
}


