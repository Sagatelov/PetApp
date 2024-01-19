//
//  ScreenBuilder.swift
//  PetProject
//
//  Created by Andrew Sagatelov on 06.12.2023.
//

import Foundation


protocol ScreenBuilderProtocol {
    func initialUserController(coordinator: CoordinatorConfigProtocol) -> UsersViewController
    func showEditUserController(user: UsersModel, coordinator:CoordinatorConfigProtocol ) -> UserEditViewController
    func postsController(coordinator: CoordinatorConfigProtocol) -> UsersViewController
    func commentsContrller(coordinator: CoordinatorConfigProtocol) -> UsersViewController
}

final class ScreenBuilder: ScreenBuilderProtocol {
    
    func showEditUserController(user: UsersModel, coordinator:CoordinatorConfigProtocol ) -> UserEditViewController {
        let network = NetworkService()
        let coreDataStorage = CoreDataStorage.sared
        let dataManager = DataManager(network: network, coreData: coreDataStorage)
        let viewModel = UserEditViewModel(user: user, dataManager: dataManager, flowCoordinator: coordinator)
        let editController = UserEditViewController.initUserEdit(viewModel: viewModel)
        return editController
    }
    
    func postsController(coordinator: CoordinatorConfigProtocol) -> UsersViewController {

        return UsersViewController()
    }
    
    func commentsContrller(coordinator: CoordinatorConfigProtocol) -> UsersViewController {
        return UsersViewController()
    }
    
    func initialUserController(coordinator: CoordinatorConfigProtocol) -> UsersViewController {
        let network = NetworkService()
        let coreDataStorage = CoreDataStorage.sared
        let dataManager = DataManager(network: network, coreData: coreDataStorage)
        let viewModel = UsersViewModel(dataManager: dataManager, flowCoordinator: coordinator)
        let usersController = UsersViewController.initUsersList(viewModel: viewModel)
        return usersController
    }
}
