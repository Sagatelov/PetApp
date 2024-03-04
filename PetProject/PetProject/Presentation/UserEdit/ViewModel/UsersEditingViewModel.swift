//
//  UsersEditingViewModel.swift
//  PetProject
//
//  Created by Andrew Sagatelov on 27.12.2023.
//

import Foundation

protocol EditViewModelOutput {
    var user: Observable<UsersModel>! { get }
    var state: Observable<State?> { get }
    var dataManager: DataManagerProtocol { get }
    var flowCoordinator: UserCoordinatorConfig { get }
}

protocol EditViewModelInput {
    func editingUser(data: [String: String])
}

typealias UserEditViewModelPorotocol = EditViewModelOutput & EditViewModelInput

final class UserEditViewModel: UserEditViewModelPorotocol {
    
    //MARK: Output
    var user: Observable<UsersModel>!
    var state: Observable<State?> = Observable(.none)
    
    var dataManager: DataManagerProtocol
    var flowCoordinator: UserCoordinatorConfig
    
    //MARK: Init
    init (user: UsersModel, dataManager: DataManagerProtocol, flowCoordinator: UserCoordinatorConfig) {
        self.dataManager = dataManager
        self.flowCoordinator = flowCoordinator
        self.user = Observable(user)
    }
    
    //MARK: Private
    
    private func saveUserChange(_ user: UsersModel) {
        dataManager.editUser(user) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let user): self.state.value = .successString("\(user.name)")
                case .failure(let error): self.state.value = .errorString(error.localizedDescription)
                }
            }
        }
    }
        
    //MARK: Input for view
    
    func editingUser(data: [String: String]) {
        let newUserData = UsersModel(newName: data["name"] ?? "\(user.value.name)",
                                     newNick: data["username"] ?? "\(user.value.username)",
                                     newEmail: data["email"] ?? "\(user.value.email)")
        
        saveUserChange(newUserData)
    }
    
}
