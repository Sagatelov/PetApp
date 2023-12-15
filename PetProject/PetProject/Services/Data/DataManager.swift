//
//  DataManeger.swift
//  PetProject
//
//  Created by Andrew Sagatelov on 14.12.2023.
//

import Foundation
import CoreData


class DataManager {
    
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
    
    
    func getPostsBy(userId: Int, complitionHandler: @escaping (Result<[PostsModel], Error>) -> Void) {
        
        coreData.getStoragePosts(byUserId: userId) { storagePosts in
            
            if storagePosts.isEmpty {
                self.network.getPostBy(userId: userId) { networkPosts in
                    
                    switch networkPosts {
                    case .success(let posts):
                        self.coreData.save(posts: posts) {
                            complitionHandler(.success(posts))}
                    case .failure(let error):
                        complitionHandler(.failure(error))
                    }
                }
                
            } else {
                complitionHandler(.success(storagePosts))
            }
        }
    }
    
    
    func getCommentsBy(postId: Int, complitionHandler: @escaping (Result<[CommentsModel], Error>) -> Void) {
        
        coreData.getStorageComments(byPostsId: postId) { storageComments in
            
            if storageComments.isEmpty {
                self.network.getCommentsBy(postId: postId) { networkComments in
                    
                    switch networkComments {
                    case .success(let posts):
                        self.coreData.save(comments: posts) {
                            complitionHandler(.success(posts))}
                    case .failure(let error):
                        complitionHandler(.failure(error))
                    }
                }
                
            } else {
                complitionHandler(.success(storageComments))
            }
        }
    }
    
}
