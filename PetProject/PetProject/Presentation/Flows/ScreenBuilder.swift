//
//  ScreenBuilder.swift
//  PetProject
//
//  Created by Andrew Sagatelov on 06.12.2023.
//

import Foundation


protocol ScreenBuilderProtocol {
    func initialUserController() -> UsersViewController
    func postsController() -> UsersViewController
    func commentsContrller() -> UsersViewController
}

final class ScreenBuilder: ScreenBuilderProtocol {
    func postsController() -> UsersViewController {

        return UsersViewController()
    }
    
    func commentsContrller() -> UsersViewController {
        return UsersViewController()
    }
    
    func initialUserController() -> UsersViewController {
        
        return UsersViewController()
    }
}
