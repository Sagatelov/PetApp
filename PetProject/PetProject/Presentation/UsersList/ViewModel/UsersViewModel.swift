//
//  UsersViewModel.swift
//  PetProject
//
//  Created by Andrew Sagatelov on 18.12.2023.
//

import Foundation

// MARK: Output
protocol UsersViewModelOutput {
    var dataManager: DataManagerProtocol { get }
    var flowCoordinator: CoordinatorConfigProtocol { get }
    var users: Observable<[UsersModel]> { get }
    var error: Observable<[Error]> { get }
}

// MARK: Inpute
protocol UsersViewModelInput {
    func delete(user: UsersModel)
    func create()
    func edit(user: UsersModel)
    func didTapToDetailController(_ usersId: UsersModel)
}

typealias UsersViewModelPorotocol = UsersViewModelInpute & UsersViewModelOutput

class UsersViewModel: UsersViewModelPorotocol {
    
    var users: [UsersModel]?
    var dataManager: DataManager
    var flowCordinator: UsersFlowCoordinator
    
    init(dataManager: DataManager, flowCordinator: UsersFlowCoordinator) {
        self.dataManager = dataManager
        self.flowCordinator = flowCordinator
    }
    
    
    
    func delete(user: UsersModel) {
    }
    
    func create() {
    }
    
    func edit(user: UsersModel) {
    }
    
    
}
