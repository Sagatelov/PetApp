//
//  ScreenBuilder.swift
//  PetProject
//
//  Created by Andrew Sagatelov on 06.12.2023.
//

import Foundation


protocol ScreenBuilderProtocol {
    func initialUserList(coordinator: CoordinatorConfigProtocol) -> UsersViewController
    func showEditUserScreen(user: UsersModel, coordinator:CoordinatorConfigProtocol ) -> UserEditViewController
    func postsList(coordinator: CoordinatorConfigProtocol, userId: Int) -> PostsListViewController
    func commentsList(coordinator: CoordinatorConfigProtocol, postsId: Int) -> CommentsListViewController
}

final class ScreenBuilder: ScreenBuilderProtocol {
    
    func showEditUserScreen(user: UsersModel, coordinator:CoordinatorConfigProtocol ) -> UserEditViewController {
        let network = NetworkService()
        let coreDataStorage = CoreDataStorage.sared
        let dataManager = DataManager(network: network, coreData: coreDataStorage)
        let viewModel = UserEditViewModel(user: user, dataManager: dataManager, flowCoordinator: coordinator)
        let editController = UserEditViewController.initUserEdit(viewModel: viewModel)
        return editController
    }
    
    func postsList(coordinator: CoordinatorConfigProtocol, userId: Int) -> PostsListViewController {
        let network = NetworkService()
        let coreDataStorage = CoreDataStorage.sared
        let dataManager = DataManager(network: network, coreData: coreDataStorage)
        let viewModel = PostsListViewModel(userId: userId, dataManager: dataManager, flowCoordinator: coordinator)
        let userListsInit = PostsListViewController.initPostsList(viewModel: viewModel)
        return userListsInit
    }
    
    func commentsList(coordinator: CoordinatorConfigProtocol, postsId: Int) -> CommentsListViewController {
        let network = NetworkService()
        let coreDataStorage = CoreDataStorage.sared
        let dataManager = DataManager(network: network, coreData: coreDataStorage)
        let viewModel = CommentsListViewModel(postId: postsId, dataManager: dataManager, flowCoordinator: coordinator)
        let initCommentsList = CommentsListViewController.initCommentsList(viewModel: viewModel)
        return initCommentsList
    }
    
    func initialUserList(coordinator: CoordinatorConfigProtocol) -> UsersViewController {
        let network = NetworkService()
        let coreDataStorage = CoreDataStorage.sared
        let dataManager = DataManager(network: network, coreData: coreDataStorage)
        let viewModel = UsersViewModel(dataManager: dataManager, flowCoordinator: coordinator)
        let usersController = UsersViewController.initUsersList(viewModel: viewModel)
        return usersController
    }
}
