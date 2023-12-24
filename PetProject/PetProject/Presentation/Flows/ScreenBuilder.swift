//
//  ScreenBuilder.swift
//  PetProject
//
//  Created by Andrew Sagatelov on 06.12.2023.
//

import Foundation


protocol ScreenBuilderProtocol {
    func initialUserController() -> UsersViewController
    func postsController() -> UsersViewController
    func commentsContrller() -> UsersViewController
}

final class ScreenBuilder: ScreenBuilderProtocol {
    func postsController() -> UsersViewController {

        return UsersViewController()
    }
    
    func commentsContrller() -> UsersViewController {
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
