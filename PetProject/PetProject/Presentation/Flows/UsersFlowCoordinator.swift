//
//  UsersFlowNavigator.swift
//  PetProject
//
//  Created by Andrew Sagatelov on 06.12.2023.
//

import Foundation
import UIKit

protocol FlowUsersProtocol: MainCoordinatorProtocol {
    func edit(user: UsersModel)
    func showComments(by postsId: Int)
    func showPosts(by userId: Int)
}

typealias UserCoordinatorConfig = FlowUsersProtocol & InitialVCForFlowNavigatorProtocol

final class UsersFlowCoordinator: UserCoordinatorConfig {
    
    var navigation: UINavigationController
    var screenBuilder: ScreenBuilderProtocol
    
    init(screenBuilder: ScreenBuilderProtocol) {
        self.screenBuilder = screenBuilder
        navigation = UINavigationController()
    }
    
    ///return initial view controller for MainFlowNavigator
    func initController() -> UIViewController {
        let usersList = screenBuilder.usersScreen(coordinator: self)
        navigation.viewControllers = [usersList]
        return navigation
    }
    
    func edit(user: UsersModel) {
        let userEdite = screenBuilder.editUserScreen(user: user, coordinator: self)
        navigation.pushViewController(userEdite, animated: true)
    }
    
    func showPosts(by userId: Int) {
        let postsList = screenBuilder.postsList(coordinator: self, userId: userId)
        navigation.pushViewController(postsList, animated: true)
    }
    
    func showComments(by postsId: Int) {
        let commentsList = screenBuilder.commentsList(coordinator: self, postsId: postsId)
        navigation.pushViewController(commentsList, animated: true)
    }
    
}



