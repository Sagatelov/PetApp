//
//  PostEditViewModel.swift
//  PetProject
//
//  Created by Andrew Sagatelov on 22.01.2024.
//

import Foundation

//MARK: Output
protocol PostEditViewModelOutput {
    var post: Observable<PostsModel>! { get }
    var state: Observable<State?> { get }
    var dataManager: DataManagerProtocol { get }
    var flowCoordinator: CoordinatorConfigProtocol { get }
}

//MARK: Input
protocol PostEditViewModelInput {
    func editingUser(data: [String: String])
}

typealias PostEditViewModelPorotocol = PostEditViewModelOutput & PostEditViewModelInput

final class PostEditViewModel: PostEditViewModelPorotocol {
    
    //MARK: Output
    var post: Observable<PostsModel>!
    var state: Observable<State?> = Observable(.none)

    var dataManager: DataManagerProtocol
    var flowCoordinator: CoordinatorConfigProtocol
    
    
    init(post: PostsModel, state: Observable<State?>, dataManager: DataManagerProtocol, flowCoordinator: CoordinatorConfigProtocol) {
        self.post.value = post
        self.dataManager = dataManager
        self.flowCoordinator = flowCoordinator
    }
    
    //MARK: Input method for view
    func editingUser(data: [String : String]) {
    }
    
    
}
