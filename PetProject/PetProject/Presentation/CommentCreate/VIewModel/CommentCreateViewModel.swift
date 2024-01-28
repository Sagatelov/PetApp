//
//  CommetCreateViewModel.swift
//  PetProject
//
//  Created by Andrew Sagatelov on 23.01.2024.
//

import Foundation

//MARK: Output
protocol CommentCreateViewModelOutput {
    var comment: Observable<CommentsModel>! { get }
    var error: Observable<[Error]> { get }
    var dataManager: DataManagerProtocol { get }
    var flowCoordinator: CoordinatorConfigProtocol { get }
}
//MARK: Input
protocol CommentCreateViewModelInput {
    func createNew()
}

typealias CommentCreateViewModelPorotocol = CommentCreateViewModelOutput & CommentCreateViewModelInput

final class CommentCreateViewModel: CommentCreateViewModelPorotocol {
    
    //MARK: Output
    var comment: Observable<CommentsModel>!
    var error: Observable<[Error]> = Observable([])
    
    var dataManager: DataManagerProtocol
    var flowCoordinator: CoordinatorConfigProtocol
    
    init(dataManager: DataManagerProtocol, flowCoordinator: CoordinatorConfigProtocol) {
        self.dataManager = dataManager
        self.flowCoordinator = flowCoordinator
    }
    
    
    //MARK: Input method for view
    func createNew() {
        
    }
}
