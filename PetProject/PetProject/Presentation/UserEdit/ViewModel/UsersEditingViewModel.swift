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
    var flowCoordinator: CoordinatorConfigProtocol { get }
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
    var flowCoordinator: CoordinatorConfigProtocol
    
    //MARK: Init
    init (user: UsersModel, dataManager: DataManagerProtocol, flowCoordinator: CoordinatorConfigProtocol) {
        self.dataManager = dataManager
        self.flowCoordinator = flowCoordinator
        self.user = Observable(user)
    }
    
    //MARK: Private
    
    private func saveUserChange() {
        dataManager.editUser(user.value) { result in
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
        
        user.value.name = data["name"] ?? "\(user.value.name)"
        user.value.username = data["username"] ?? "\(user.value.username)"
        user.value.email = data["email"] ?? "\(user.value.email)"
        
        saveUserChange()
    }
    
}
