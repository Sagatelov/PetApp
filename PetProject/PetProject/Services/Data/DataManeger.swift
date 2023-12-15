//
//  DataManeger.swift
//  PetProject
//
//  Created by Andrew Sagatelov on 14.12.2023.
//

import Foundation
import CoreData


class DataManeger {
    
    let network = NetworkService()
    let coreData = CoreDataStorage.sared
    
    
    
    
    func getAllUsers(complitionHandler: @escaping (Result<[UsersModel], Error>) -> Void) {
        
        coreData.getStorageUsers { [weak self] storageUsers in
            
            if storageUsers.isEmpty {
                self?.network.getAllUsers { networkUsers in
                    
                    switch networkUsers {
                    case .success(let users):
                        self?.coreData.save(users: users) {
                            complitionHandler(.success(users))}
                        
                    case .failure(let error):
                        complitionHandler(.failure(error))
                    }
                }
                
            } else {
                complitionHandler(.success(storageUsers))
            }
        }
    }
}
