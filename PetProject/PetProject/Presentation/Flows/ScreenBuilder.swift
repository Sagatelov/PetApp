//
//  ScreenBuilder.swift
//  PetProject
//
//  Created by Andrew Sagatelov on 06.12.2023.
//

import Foundation


protocol ScreenBuilderProtocol {
    
    //MARK: Registration Flow
    func signUpScreen(coordinator: RegistrationCoordinatorConfig) -> SignUpViewController
    func loginScreen(coordinator:  RegistrationCoordinatorConfig) -> LoginViewController
    func welcomeScreen(coordinator: RegistrationCoordinatorConfig) -> WelcomeViewController
    
    //MARK: User Flow
    func usersScreen(coordinator: UserCoordinatorConfig) -> UsersViewController
    func editUserScreen(user: UsersModel, coordinator:UserCoordinatorConfig ) -> UserEditViewController
    func postsList(coordinator: UserCoordinatorConfig, userId: Int) -> PostsListViewController
    func commentsList(coordinator: UserCoordinatorConfig, postsId: Int) -> CommentsListViewController
    
    //MARK: Profile Flow
    func profileScreen(coordinator: ProfileCoordinatorConfig) -> ProfileViewController
    func favoritesScreen(coordinator: ProfileCoordinatorConfig) -> FavoritesViewController
    
    //MARK: Services init
    init(network: NetworkServiceProtocol, coreDataStorage: CoreDataStorage, authManager: AuthManagerProtocol)
}

final class ScreenBuilder: ScreenBuilderProtocol {
    var dataManager: DataManagerProtocol
    var network: NetworkServiceProtocol
    var coreDataStorage: CoreDataStorage
    var authManager: AuthManagerProtocol
    
    init(network: NetworkServiceProtocol, coreDataStorage: CoreDataStorage, authManager: AuthManagerProtocol) {
        self.network = network
        self.coreDataStorage = coreDataStorage
        self.authManager = authManager
        self.dataManager = DataManager(network: network, coreData: coreDataStorage)
    }
    
    //MARK: - Registration Flow
    func welcomeScreen(coordinator: RegistrationCoordinatorConfig) -> WelcomeViewController {
        let viewModel = WelcomeViewModel(dataManager: dataManager, flowCoordinator: coordinator)
        let screen = WelcomeViewController.initWelcomeScreen(viewModel: viewModel)
        return screen
    }
    
    func signUpScreen(coordinator: RegistrationCoordinatorConfig) -> SignUpViewController {
        let viewModel = SignUpViewModel(dataManager: dataManager, flowCoordinator: coordinator, authManager: authManager)
        let screen = SignUpViewController.initSignScreen(viewModel: viewModel)
        return screen
    }
    
    func loginScreen(coordinator:  RegistrationCoordinatorConfig) -> LoginViewController {
        let viewModel = LoginViewModel(dataManager: dataManager, flowCoordinator: coordinator, authManager: authManager)
        let screen = LoginViewController.initLoginScreen(viewModel: viewModel)
        return screen
    }
    
    //MARK: - User Flow
    func editUserScreen(user: UsersModel, coordinator: UserCoordinatorConfig ) -> UserEditViewController {
        let viewModel = UserEditViewModel(user: user, dataManager: dataManager, flowCoordinator: coordinator)
        let editController = UserEditViewController.initUserEdit(viewModel: viewModel)
        return editController
    }
    
    func postsList(coordinator: UserCoordinatorConfig, userId: Int) -> PostsListViewController {
        let viewModel = PostsListViewModel(userId: userId, dataManager: dataManager, flowCoordinator: coordinator)
        let userListsInit = PostsListViewController.initPostsList(viewModel: viewModel)
        return userListsInit
    }
    
    func commentsList(coordinator: UserCoordinatorConfig, postsId: Int) -> CommentsListViewController {
        let viewModel = CommentsListViewModel(postId: postsId, dataManager: dataManager, flowCoordinator: coordinator)
        let initCommentsList = CommentsListViewController.initCommentsList(viewModel: viewModel)
        return initCommentsList
    }
    
    func usersScreen(coordinator: UserCoordinatorConfig) -> UsersViewController {
        let viewModel = UsersViewModel(dataManager: dataManager, flowCoordinator: coordinator)
        let usersController = UsersViewController.initUsersList(viewModel: viewModel)
        return usersController
    }
    
    //MARK: - Profile Flow
    func profileScreen(coordinator: ProfileCoordinatorConfig) -> ProfileViewController {
        let viewModel = ProfileViewModel(dataManager: dataManager, flowCoordinator: coordinator)
        let controller = ProfileViewController.initProfileController(viewModel: viewModel)
        return controller
    }
    
    func favoritesScreen(coordinator: ProfileCoordinatorConfig) -> FavoritesViewController {
        let viewModel = FavoritesViewModel(dataManager: dataManager, flowCoordinator: coordinator)
        let conroller = FavoritesViewController.initFavoritesController(viewModel: viewModel)
        return conroller
    }
}
