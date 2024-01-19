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

// MARK: Input
protocol UsersViewModelInput {
    func viewDidLoad()
    func delete(user: UsersModel)
    func create()
    func edit(user: UsersModel)
    func didTapToDetailController(_ usersId: UsersModel)
}

typealias UsersViewModelPorotocol = UsersViewModelInput & UsersViewModelOutput

final class UsersViewModel: UsersViewModelPorotocol {
    
    var error: Observable<[Error]> = (Observable([]))
    var users: Observable<[UsersModel]> = (Observable([]))
    var dataManager: DataManagerProtocol
    var flowCoordinator: CoordinatorConfigProtocol
    
    init(dataManager: DataManagerProtocol, flowCoordinator: CoordinatorConfigProtocol) {
        self.dataManager = dataManager
        self.flowCoordinator = flowCoordinator
    }
    
    
    
    private func loadUser() {
        dataManager.getAllUsers { users in
            DispatchQueue.main.async {
                switch users {
                case .success(let users):
                    self.users.value = users
                case .failure(let error):
                    self.error.value = [error]
                }
            }
        }
    }
    
    
    //MARK: Input - view metods
    func viewDidLoad() {
        loadUser()
    }
    
    func delete(user: UsersModel) {
    }
    
    func create() {
    }
    
    func edit(user: UsersModel) {
        flowCoordinator.edit(user: user)
    }
    
    func didTapToDetailController(_ usersId: UsersModel) {
    }
    
}
