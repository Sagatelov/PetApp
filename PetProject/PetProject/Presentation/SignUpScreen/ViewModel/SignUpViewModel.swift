//
//  SignUpViewModel.swift
//  PetProject
//
//  Created by Andrew Sagatelov on 08.02.2024.
//

import Foundation

protocol SignUpViewModelOutput {
    var dataManager: DataManagerProtocol { get }
    var flowCoordinator: RegistrationCoordinatorConfig  { get }
    var authManager: AuthManagerProtocol { get }
    var error: Observable<String> { get }
    var user: Observable<UsersModel>? { get }
    var alert: Observable<String> { get }
}

protocol SignUpViewModelInput {
    func didTapSignUp(_ usersData: [String: String])
}

typealias SignUpViewModelPorotocol = SignUpViewModelOutput & SignUpViewModelInput

final class SignUpViewModel: SignUpViewModelPorotocol {
    
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
    
    private func newUserSuccessDidCreate() {
        if let user = user?.value {
            NotificationCenter.default.post(name: .newUserDidReg, object: nil, userInfo: ["user": user])
        }
    }
    
    //MARK: Input
    func didTapSignUp(_ userData: [String: String]) {
        guard let name = userData["name"],
              let nick = userData["nick"],
              let password = userData["password"],
              let email = userData["email"] else { return }
        
        authManager.createUser(email: email, password: password) { success in
            if success {
                var newUser = UsersModel(newName: name, newNick: nick, newEmail: email)
                self.dataManager.createUser(newUser) { result in
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let user):
                            newUser.id = user.id
                            self.user = Observable(newUser)
                            self.newUserSuccessDidCreate()
                            self.alert.value = "User was sucessfully created."
                        case .failure(_):
                            self.error.value = "Network error"
                        }
                    }
                }
            } else {
                self.error.value = "Еrror during user creation"
            }
        }
    }
}
