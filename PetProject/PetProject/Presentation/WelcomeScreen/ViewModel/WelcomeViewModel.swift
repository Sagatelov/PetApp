//
//  WelcomeViewModel.swift
//  PetProject
//
//  Created by Andrew Sagatelov on 08.02.2024.
//

import Foundation

//MARK: Output
protocol WelcomeViewModelOutput {
    var dataManager: DataManagerProtocol { get }
    var flowCoordinator: RegistrationCoordinatorConfig  { get }
}

//MARK: Input
protocol WelcomeViewModelInput  {
    func signUp()
    func login()
}

typealias WelcomeViewModelPorotocol = WelcomeViewModelOutput & WelcomeViewModelInput

final class WelcomeViewModel: WelcomeViewModelPorotocol {
    
    var dataManager: DataManagerProtocol
    var flowCoordinator: RegistrationCoordinatorConfig
    
    init(dataManager: DataManagerProtocol, flowCoordinator: RegistrationCoordinatorConfig) {
        self.dataManager = dataManager
        self.flowCoordinator = flowCoordinator
    }
    
    
    //MARK: Input method
    func signUp() {
        flowCoordinator.signUpScreen()
    }
    
    func login() {
        flowCoordinator.loginScreen()
    }
    
}
