//
//  UsersViewModel.swift
//  PetProject
//
//  Created by Andrew Sagatelov on 18.12.2023.
//

import Foundation

// MARK: Output
protocol UsersViewModelOutput {
    var users: Observable<[UsersModel]> { get }
    var error: Observable<[Error]> { get }
    var alert: Observable<State?> { get }
    var dataManager: DataManagerProtocol { get }
    var flowCoordinator: UserCoordinatorConfig { get }
}

// MARK: Input
protocol UsersViewModelInput {
    func viewDidLoad()
    func deleteUserBy(id: Int)
    func edit(user: UsersModel)
    func didTapOnUser(_ usersId: Int)
}

typealias UsersViewModelPorotocol = UsersViewModelInput & UsersViewModelOutput

final class UsersViewModel: UsersViewModelPorotocol {
    
    var alert: Observable<State?> = Observable(.none)
    var error: Observable<[Error]> = Observable([])
    var users: Observable<[UsersModel]> = Observable([])
    
    var sinupStatusViewModel: SignUpViewModelPorotocol!
    
    var dataManager: DataManagerProtocol
    var flowCoordinator: UserCoordinatorConfig
    
    init(dataManager: DataManagerProtocol, flowCoordinator: UserCoordinatorConfig) {
        self.dataManager = dataManager
        self.flowCoordinator = flowCoordinator
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handeleNewData(_:)),
                                               name: .newUserDidReg, object: nil)
    }
    
    @objc private func handeleNewData(_ notification: Notification) {
        loadUser()
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
    
    func edit(user: UsersModel) {
        flowCoordinator.edit(user: user)
    }
    
    func didTapOnUser(_ usersId: Int) {
        flowCoordinator.showPosts(by: usersId)
        
    }
}
