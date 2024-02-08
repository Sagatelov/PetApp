//
//  CommentEditViewModel.swift
//  PetProject
//
//  Created by Andrew Sagatelov on 23.01.2024.
//

import Foundation

//MARK: Output
protocol CommentEditViewModelOutput {
    var comment: Observable<CommentsModel>! { get }
    var state: Observable<State?> { get }
    var dataManager: DataManagerProtocol { get }
    var flowCoordinator: CoordinatorConfigProtocol { get }
}

//MARK: Input
protocol CommentEditViewModelInput {
    func editingComment(data: [String: String])
}

typealias CommentEditViewModelPorotocol = CommentEditViewModelOutput & CommentEditViewModelInput

class CommentEditViewModel: CommentEditViewModelPorotocol {
    
    //MARK: Output
    var comment: Observable<CommentsModel>!
    var state: Observable<State?> = Observable(.none)
    
    var dataManager: DataManagerProtocol
    var flowCoordinator: CoordinatorConfigProtocol
    
    init(comment: CommentsModel, state: Observable<State?>, dataManager: DataManagerProtocol, flowCoordinator: CoordinatorConfigProtocol) {
        self.comment.value = comment
        self.dataManager = dataManager
        self.flowCoordinator = flowCoordinator
    }
    
    
    //MARK: Input method for view
    func editingComment(data: [String : String]) {
    }
    
    
}
