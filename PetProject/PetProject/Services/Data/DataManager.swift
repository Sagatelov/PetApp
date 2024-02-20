//
//  DataManeger.swift
//  PetProject
//
//  Created by Andrew Sagatelov on 14.12.2023.
//

import Foundation
import CoreData

protocol DataManagerProtocol {
    //users manage
    func getAllUsers(completion: @escaping (Result<[UsersModel], Error>) -> Void)
    func getUserBy(email: String, completion: @escaping (State) -> Void)
    func editUser(_ user: UsersModel, completion: @escaping (Result<UsersModel, Error>) -> Void)
    func deleteUser(_ userId: Int, completion: @escaping (Result<UsersModel, Error>) -> Void)
    func createUser(_ user: UsersModel, completion: @escaping (Result<UsersModel, Error>) -> Void)
    
    //posts manage
    func getPostsBy(userId: Int, completion: @escaping (Result<[PostsModel], Error>) -> Void)
    
    //comments manage
    func getCommentsBy(postId: Int, completion: @escaping (Result<[CommentsModel], Error>) -> Void)
    
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
    func getAllUsers(completion: @escaping (Result<[UsersModel], Error>) -> Void) {
        coreData.getStorageUsers { [weak self] storageUsers in
            
            if storageUsers.isEmpty {
                self?.network.getAllUsers { networkUsers in
                    
                    switch networkUsers {
                    case .success(let users):
                        self?.coreData.save(users: users) {
                            completion(.success(users))}
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
                
            } else {
                completion(.success(storageUsers))
            }
        }
    }
    
    func getUserBy(email: String, completion: @escaping (State) -> Void) {
        coreData.getUserBy(email: email) { user in
            if let user = user {
                completion(.successUser(user))
            } else {
                let error = "User do not find!"
                completion(.errorString(error))
            }
        }
    }
    
    func createUser(_ user: UsersModel, completion: @escaping (Result<UsersModel, Error>) -> Void) {
        network.createUser(user: user) { result in
            switch result {
            case .success(let createdUser):
                self.coreData.save(users: [createdUser]) {
                    completion(.success(createdUser))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func editUser(_ user: UsersModel, completion: @escaping (Result<UsersModel, Error>) -> Void) {
        
        network.editUser(user: user) { result in
            switch result {
            case .success(let editedUser):
                completion(.success(editedUser))
                self.coreData.update(user: user) { userEntity in
                    userEntity.email = user.email
                    userEntity.id = Int64(user.id)
                    userEntity.name = user.name
                    userEntity.username = user.username
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func deleteUser(_ userId: Int, completion: @escaping (Result<UsersModel, Error>) -> Void) {
        network.deleteBy(userId: userId) { result in
            switch result {
            case .success(let deletedUser):
                completion(.success(deletedUser))
                self.coreData.deleteUser(byId: userId) {
                    print("success delete")
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    //MARK: - Posts
    
    func getPostsBy(userId: Int, completion: @escaping (Result<[PostsModel], Error>) -> Void) {
        coreData.getStoragePosts(byUserId: userId) { storagePosts in
            
            if storagePosts.isEmpty {
                self.network.getPostsBy(userId: userId) { networkPosts in
                    
                    switch networkPosts {
                    case .success(let posts):
                        self.coreData.save(posts: posts) {
                            completion(.success(posts))}
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
                
            } else {
                completion(.success(storagePosts))
            }
        }
    }
    
    //MARK: - Comments
    
    func getCommentsBy(postId: Int, completion: @escaping (Result<[CommentsModel], Error>) -> Void) {
        coreData.getStorageComments(byPostsId: postId) { storageComments in
            
            if storageComments.isEmpty {
                self.network.getCommentsBy(postId: postId) { networkComments in
                    
                    switch networkComments {
                    case .success(let posts):
                        self.coreData.save(comments: posts) {
                            completion(.success(posts))}
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
                
            } else {
                completion(.success(storageComments))
            }
        }
    }
    
}
