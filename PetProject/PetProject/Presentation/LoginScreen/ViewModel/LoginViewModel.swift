//
//  LoginViewModel.swift
//  PetProject
//
//  Created by Andrew Sagatelov on 08.02.2024.
//

import Foundation

protocol LoginViewModelOutput {
    var dataManager: DataManagerProtocol { get }
    var flowCoordinator: RegistrationCoordinatorConfig  { get }
    var error: Observable<String> { get }
    var alert: Observable<String> { get }
    var user: Observable<UsersModel>? { get }
}

protocol LoginViewModelInput {
    func didTabLoginWith(data: [String: String])
    func userSuccessDidLogin()
}

typealias LoginViewModelPorotocol = LoginViewModelOutput & LoginViewModelInput

final class LoginViewModel: LoginViewModelPorotocol {

    var dataManager: DataManagerProtocol
    var flowCoordinator: RegistrationCoordinatorConfig
    var authManager: AuthManagerProtocol
    
    var error: Observable<String> = Observable("")
    var alert: Observable<String> = Observable("")
    var user: Observable<UsersModel>?
    init(dataManager: DataManagerProtocol, flowCoordinator: RegistrationCoordinatorConfig, authManager: AuthManagerProtocol) {
        self.dataManager = dataManager
        self.flowCoordinator = flowCoordinator
        self.authManager = authManager
    }
    
    //MARK: Input
    func userSuccessDidLogin() {
        if let user = user?.value {
            NotificationCenter.default.post(name: .userDidLogin, object: nil, userInfo: ["user": user])
        }
    }
    
    func didTabLoginWith(data: [String: String]) {
        guard let email = data["email"],
              let password = data["password"] else { return }
        
        authManager.signIn(email: email, pass: password) { success in
            if success {
                self.dataManager.getUserBy(email: email) { state in
                    if case .successUser(let users) = state {
                        self.user = Observable(users)
                        self.alert.value = "Success"
                    } else if case .errorString(let error) = state {
                        self.error.value = error
                    }
                }
            } else {
                self.error.value = "User with such data was not found"
            }
        }
    }
    
}
