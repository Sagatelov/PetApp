//
//  DataManeger.swift
//  PetProject
//
//  Created by Andrew Sagatelov on 14.12.2023.
//

import Foundation
import CoreData

protocol DataManagerProtocol {
    func getAllUsers(completionHandler: @escaping (Result<[UsersModel], Error>) -> Void)
    func getPostsBy(userId: Int, completionHandler: @escaping (Result<[PostsModel], Error>) -> Void)
    func getCommentsBy(postId: Int, completionHandler: @escaping (Result<[CommentsModel], Error>) -> Void)
    func editUser(_ user: UsersModel, completion: @escaping (Result<UsersModel, Error>) -> Void)
    init(network: NetworkServiceProtocol, coreData: CoreDataStorage)
}


final class DataManager: DataManagerProtocol {
    
    let network: NetworkServiceProtocol
    let coreData: CoreDataStorage
    
    required init(network: NetworkServiceProtocol, coreData: CoreDataStorage) {
        self.network = network
        self.coreData = coreData
    }

    //MARK: - Users
    
    func getAllUsers(completionHandler: @escaping (Result<[UsersModel], Error>) -> Void) {
        
        coreData.getStorageUsers { [weak self] storageUsers in
            
            if storageUsers.isEmpty {
                self?.network.getAllUsers { networkUsers in
                    
                    switch networkUsers {
                    case .success(let users):
                        self?.coreData.save(users: users) {
                            completionHandler(.success(users))}
                    case .failure(let error):
                        completionHandler(.failure(error))
                    }
                }
                
            } else {
                completionHandler(.success(storageUsers))
            }
        }
    }
    
    func editUser(_ user: UsersModel, completion: @escaping (Result<UsersModel, Error>) -> Void) {
        coreData.update(user: user) { userEntity in
            userEntity.email = user.email
            userEntity.id = Int64(user.id)
            userEntity.name = user.name
            userEntity.username = user.username
        }
        network.editingUser(user: user) { result in
            switch result {
            case .success(let editedUser):
                completion(.success(editedUser))
                print(editedUser)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    //MARK: - Posts
    
    func getPostsBy(userId: Int, completionHandler: @escaping (Result<[PostsModel], Error>) -> Void) {
        
        coreData.getStoragePosts(byUserId: userId) { storagePosts in
            
            if storagePosts.isEmpty {
                self.network.getPostBy(userId: userId) { networkPosts in
                    
                    switch networkPosts {
                    case .success(let posts):
                        self.coreData.save(posts: posts) {
                            completionHandler(.success(posts))}
                    case .failure(let error):
                        completionHandler(.failure(error))
                    }
                }
                
            } else {
                completionHandler(.success(storagePosts))
            }
        }
    }
    
    //MARK: - Comments
    
    func getCommentsBy(postId: Int, completionHandler: @escaping (Result<[CommentsModel], Error>) -> Void) {
        
        coreData.getStorageComments(byPostsId: postId) { storageComments in
            
            if storageComments.isEmpty {
                self.network.getCommentsBy(postId: postId) { networkComments in
                    
                    switch networkComments {
                    case .success(let posts):
                        self.coreData.save(comments: posts) {
                            completionHandler(.success(posts))}
                    case .failure(let error):
                        completionHandler(.failure(error))
                    }
                }
                
            } else {
                completionHandler(.success(storageComments))
            }
        }
    }
    
}
