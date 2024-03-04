//
//  CommentsListViewModel.swift
//  PetProject
//
//  Created by Andrew Sagatelov on 22.01.2024.
//

import Foundation

//MARK: Output
protocol CommentsListViewModelInput {
    var postId: Observable<Int>! { get }
    var comments: Observable<[CommentsModel]> { get }
    var error: Observable<[Error]> { get }
    var dataManager: DataManagerProtocol { get }
    var flowCoordinator: UserCoordinatorConfig { get }
}

//MARK: Input
protocol CommentsListViewModelOutput {
    func edit(comments: CommentsModel)
    func deletePostBy(id: Int)
    func createPost()
    func viewDidLoad()
}

typealias CommentsListViewModelPorotocol = CommentsListViewModelInput & CommentsListViewModelOutput

final class CommentsListViewModel: CommentsListViewModelPorotocol {
    
    
    //MARK: Output
    var postId: Observable<Int>!
    var comments: Observable<[CommentsModel]> = Observable([])
    var error: Observable<[Error]> = Observable([])
    
    var dataManager: DataManagerProtocol
    var flowCoordinator: UserCoordinatorConfig
    
    
    init(postId: Int, dataManager: DataManagerProtocol, flowCoordinator: UserCoordinatorConfig) {
        self.postId = Observable(postId)
        self.dataManager = dataManager
        self.flowCoordinator = flowCoordinator
    }
    
    private func loadComments() {
        dataManager.getCommentsBy(postId: postId.value) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let comments): self.comments.value = comments
                case .failure(let error): self.error.value = [error]
                }
            }
        }
    }
    
    //MARK: Input method for view
    
    
    func viewDidLoad() {
       loadComments()
    }
    
    func edit(comments: CommentsModel) {
      
    }
    
    func deletePostBy(id: Int) {
      
    }
    
    func createPost() {
   
    }
    
    
}
