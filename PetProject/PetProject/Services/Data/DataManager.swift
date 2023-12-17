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
}


class DataManager: DataManagerProtocol {
    
    let network = NetworkService()
    let coreData = CoreDataStorage.sared
    
    
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
