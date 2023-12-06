//
//  ScreenBuilder.swift
//  PetProject
//
//  Created by Andrew Sagatelov on 06.12.2023.
//

import Foundation


protocol ScreenBuilderProtocol {
    func initialUserController() -> ViewController
    func postsController() -> ViewController
    func commentsContrller() -> ViewController
}

final class ScreenBuilder: ScreenBuilderProtocol {
    func postsController() -> ViewController {
        return ViewController()
    }
    
    func commentsContrller() -> ViewController {
        return ViewController()
    }
    
    func initialUserController() -> ViewController {
        return ViewController()
    }
}
