//
//  ProfileViewModel.swift
//  PetProject
//
//  Created by Andrew Sagatelov on 14.02.2024.
//

import Foundation

protocol ProfileViewModelOutput {
    var dataManager: DataManagerProtocol { get }
    var flowCoordinator: ProfileCoordinatorConfig { get }
    var user: Observable<UsersModel>! { get }
}

protocol ProfileViewModelInput {
    func favoritesCellDidTap()
    func postsCellDidTap()
}

typealias ProfileViewModelPorotocol = ProfileViewModelOutput & ProfileViewModelInput

final class ProfileViewModel: ProfileViewModelPorotocol {
    
    var dataManager: DataManagerProtocol
    var flowCoordinator: ProfileCoordinatorConfig
    var user: Observable<UsersModel>!
    
    init(dataManager: DataManagerProtocol, flowCoordinator: ProfileCoordinatorConfig) {
        self.dataManager = dataManager
        self.flowCoordinator = flowCoordinator
        NotificationCenter.default.addObserver(self, selector: #selector(createProfileByUser(_:)), name: .newUserDidReg, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(createProfileByUser(_:)), name: .userDidLogin, object: nil)
    }
    
    @objc private func createProfileByUser(_ notification: Notification) {
        if let object = notification.userInfo?["user"] as? UsersModel {
            user = Observable(object)
            print(user.value)
        }
    }
    
    func favoritesCellDidTap() {
        flowCoordinator.favoritesScreen()
    }
    
    func postsCellDidTap() {
        
    }
}
