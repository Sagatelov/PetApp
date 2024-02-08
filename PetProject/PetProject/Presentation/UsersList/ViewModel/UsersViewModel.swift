//
//  UsersViewModel.swift
//  PetProject
//
//  Created by Andrew Sagatelov on 18.12.2023.
//

import Foundation

// MARK: Outputsa
protocol UsersViewModelOutput {
    var users: Observable<[UsersModel]> { get }
    var error: Observable<[Error]> { get }
    var alert: Observable<State?> { get }
    var dataManager: DataManagerProtocol { get }
    var flowCoordinator: CoordinatorConfigProtocol { get }
}

// MARK: Input
protocol UsersViewModelInput {
    func viewDidLoad()
    func deleteUserBy(id: Int)
//    func create()
    func edit(user: UsersModel)
    func didTapOnUser(_ usersId: Int)
}

typealias UsersViewModelPorotocol = UsersViewModelInput & UsersViewModelOutput

final class UsersViewModel: UsersViewModelPorotocol {
    
    var alert: Observable<State?> = Observable(.none)
    var error: Observable<[Error]> = Observable([])
    var users: Observable<[UsersModel]> = Observable([])
    
    
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
                    self.error.value = [error] }
            }
        }
    }
    
    
    //MARK: Input - view methods
    
    func viewDidLoad() {
        loadUser()
    }
    
    func deleteUserBy(id: Int) {
        dataManager.deleteUser(id) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let deletedUser): self.alert.value = .successString("\(deletedUser.id)")
                case .failure(let error): self.error.value = [error]
                }
            }
        }
    }
    
//    func create() {
//    }
    
    func edit(user: UsersModel) {
        flowCoordinator.edit(user: user)
    }
    
    func didTapOnUser(_ usersId: Int) {
        flowCoordinator.showPosts(by: usersId)
    }
    
}
