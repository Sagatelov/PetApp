//
//  PostCreateViewModel.swift
//  PetProject
//
//  Created by Andrew Sagatelov on 22.01.2024.
//

import Foundation

//MARK: Output
protocol PostCreateViewModelOutput {
    var post: Observable<PostsModel>! { get }
    var error: Observable<[Error]> { get }
    var dataManager: DataManagerProtocol { get }
    var flowCoordinator: CoordinatorConfigProtocol { get }
}
//MARK: Input
protocol PostCreateViewModelInput {
    func createNew()
}

typealias PostCreateViewModelPorotocol = PostCreateViewModelOutput & PostCreateViewModelInput

final class PostCreateViewModel: PostCreateViewModelPorotocol {
    
    //MARK: Output
    var post: Observable<PostsModel>!
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
