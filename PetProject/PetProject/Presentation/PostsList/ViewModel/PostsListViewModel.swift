//
//  PostsListsViewModel.swift
//  PetProject
//
//  Created by Andrew Sagatelov on 22.01.2024.
//

import Foundation

//MARK: Output
protocol PostsListViewModelInput {
    var userId: Observable<Int> { get }
    var error: Observable<[Error]> { get }
    var dataManager: DataManagerProtocol { get }
    var flowCoordinator: UserCoordinatorConfig { get }
    var posts: Observable<[PostsModel]> { get }
}

//MARK: Input
protocol PostsListViewModelOutput {
    func didTapOnPosts(_ postsId: Int)
    func viewDidLoad()
    func favoritesButtonDidTap(state: Bool, id: Int)
    func favoritesLoadDataWith(id: Int) -> Bool
}

typealias PostsListViewModelPorotocol = PostsListViewModelInput & PostsListViewModelOutput

final class PostsListViewModel: PostsListViewModelPorotocol {
    
    //MARK: Output
    var userId: Observable<Int>
    var posts: Observable<[PostsModel]> = Observable([])
    var error: Observable<[Error]> = Observable([])
    var dataManager: DataManagerProtocol
    var flowCoordinator: UserCoordinatorConfig
    
    init(userId: Int, dataManager: DataManagerProtocol, flowCoordinator: UserCoordinatorConfig) {
        self.userId = Observable(userId)
        self.dataManager = dataManager
        self.flowCoordinator = flowCoordinator
    }
    
    private func getPosts() {
        dataManager.getPostsBy(userId: userId.value) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let post):
                    self.posts.value = post
                case .failure(let error):
                    self.error.value = [error]
                }
            }
        }
    }
    
    //MARK: Input method for view
    func viewDidLoad() {
        getPosts()
    }
    
    func didTapOnPosts(_ postsId: Int) {
        flowCoordinator.showComments(by: postsId)
    }
    
    func favoritesButtonDidTap(state: Bool, id: Int) {
        UserDefaultStorage.saveFavorites(isActive: state, idKey: id)
    }
    
    func favoritesLoadDataWith(id: Int) -> Bool {
        UserDefaultStorage.loadFavorites(idKey: id)
    }
}


