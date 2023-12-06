//
//  UsersFlowNavigator.swift
//  PetProject
//
//  Created by Andrew Sagatelov on 06.12.2023.
//

import Foundation
import UIKit

protocol MainFlowCoordinatorProtocol {
    var navigationController: UINavigationController { get set }
    var screenBuilder: ScreenBuilderProtocol { get set }
}

protocol FlowUsersProtocol: MainFlowCoordinatorProtocol {
    func showComments()
    func showPosts()
    func popToRoot()
}

final class UsersFlowCoordinator {
    
}


extension UsersFlowCoordinator: InitControllerForFlowNavigatorProtocol {
    func initController() -> ViewController {
        return ViewController()
    }
}
