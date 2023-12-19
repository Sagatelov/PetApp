//
//  UsersViewModel.swift
//  PetProject
//
//  Created by Andrew Sagatelov on 18.12.2023.
//

import Foundation

protocol UsersViewModelOutput {
    var dataManager: DataManager { get }
    var flowCordinator: UsersFlowCoordinator { get }
    var users: [UsersModel]? { get }
}

protocol UsersViewModelInpute {
    func delete(user: UsersModel)
    func create()
    func edit(user: UsersModel)
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
