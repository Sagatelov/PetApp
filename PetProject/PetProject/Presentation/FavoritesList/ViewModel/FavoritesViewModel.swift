//
//  FavoritesViewModel.swift
//  PetProject
//
//  Created by Andrew Sagatelov on 26.02.2024.
//

import Foundation
//MARK: Output
protocol FavoritesViewModelOutput {
    var favoritesPosts: Observable<[PostsModel]> { get }
    var dataManager: DataManagerProtocol { get }
    var flowCoordinator: ProfileCoordinatorConfig { get }
}
//MARK: Input
protocol FavoritesViewModelInput {
    func viewDidLoad()
    func removeFavoritesDidTap(state: Bool, id: Int)
}

typealias FavoritesViewModelPorotocol = FavoritesViewModelOutput & FavoritesViewModelInput

final class FavoritesViewModel: FavoritesViewModelPorotocol {
    
    var favoritesPosts: Observable<[PostsModel]> = Observable([])
    
    var dataManager: DataManagerProtocol
    var flowCoordinator: ProfileCoordinatorConfig
    
    init(dataManager: DataManagerProtocol, flowCoordinator: ProfileCoordinatorConfig) {
        self.dataManager = dataManager
        self.flowCoordinator = flowCoordinator
    }
    
    //MARK: Input method for View
    func viewDidLoad() {
        dataManager.getPosts { posts in
            let post = posts.filter { UserDefaultStorage.loadFavorites(idKey: $0.id) }
            if !post.isEmpty {
                self.favoritesPosts.value = post
            }
        }
    }
    
    func removeFavoritesDidTap(state: Bool, id: Int) {
        UserDefaultStorage.saveFavorites(isActive: state, idKey: id)
    }
}
