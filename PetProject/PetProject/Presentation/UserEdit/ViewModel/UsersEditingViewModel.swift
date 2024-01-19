//
//  UsersEditingViewModel.swift
//  PetProject
//
//  Created by Andrew Sagatelov on 27.12.2023.
//

import Foundation

protocol EditViewModelInput {
    func viewDidLoad()
    func editingUser(data: [String: String])
}

protocol EditViewModelOutput {
    var dataManager: DataManagerProtocol { get }
    var flowCoordinator: CoordinatorConfigProtocol { get }
    var user: Observable<UsersModel>! { get }
    var state: Observable<State?> { get }
}
typealias UserEditViewModelPorotocol = EditViewModelOutput & EditViewModelInput

class UserEditViewModel: UserEditViewModelPorotocol {
    
    //MARK: Output
    var dataManager: DataManagerProtocol
    var flowCoordinator: CoordinatorConfigProtocol
    var user: Observable<UsersModel>!
    var state: Observable<State?> = Observable(.none)
    
    
    //MARK: Init
    init (user: UsersModel, dataManager: DataManagerProtocol, flowCoordinator: CoordinatorConfigProtocol) {
        self.dataManager = dataManager
        self.flowCoordinator = flowCoordinator
        self.user = Observable(user)
    }
    
    //MARK: Private
    
    private func saveUserChange() {
        dataManager.editUser(user.value) { result in
            switch result {
            case .success(_):
                self.handler(resultState: .success)
            case .failure(let error):
                self.handler(resultState: .errorString(error.localizedDescription))
            }
        }
    }
    
    private func handler(resultState: State) {
        
        switch resultState {
        case .success:
            state.value = .success
        case .errorString(let error):
            state.value = .errorString("Произошла ошибка сохранения. \nОписание ошибки \(error)")
        }
    }
    
    //MARK: Input for view
    func viewDidLoad() {
        user.updateObserver()
    }
    
    func editingUser(data: [String: String]) {
        
        let newValueKeys = data.map { $0.key }
        
        var userData = ["name": user.value.name,
                        "userName": user.value.username,
                        "email": user.value.email]
        
        for (key, _) in userData {
            if newValueKeys.contains(key) {
                userData[key] = data[key]
            }
        }
        
        saveUserChange()
    }
    
}
