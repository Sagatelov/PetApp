//
//  CoreDataStorage.swift
//  PetProject
//
//  Created by Andrew Sagatelov on 05.12.2023.
//

import Foundation
import CoreData

final class CoreDataStorage {
    // MARK: - Core Data stack
    
    static var sared = CoreDataStorage()
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "PetProject")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Не удалось загрузить хранилище данных: \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Ошибка сохранения в CoreData: \(error)")
            }
        }
    }
    
    // MARK: - privat init
    
    private init () { }
    
    
    // MARK: - Users
    
    func getStorageUsers(completionHandler: @escaping ([UsersModel]) -> Void) {
        
        let context = persistentContainer.viewContext
        context.perform {
            do {
                let fetchUsersEntities = try UsersEntity.fetchUserEntities(context: context)
                let users = fetchUsersEntities.map { UsersModel(entity: $0) }
                completionHandler(users)
            } catch {
                print("Failed to load all Users: \(error)")
            }
        }
    }
    
    func getUserBy(email: String, completionHandler: @escaping (UsersModel?) -> Void) {
        
        let context = persistentContainer.viewContext
        context.perform {
            do {
                if let user = try UsersEntity.findAndUpdate(entity: UsersEntity.self, searchType: .email(email), context: context),
                   let result = user as? UsersEntity {
                    
                    let foundUser = UsersModel(entity: result)
                    completionHandler(foundUser)}
                
            } catch {
                print("Failed to load user by email: \(error)")
            }
        }
        
    }
    
    func save(users: [UsersModel], completionHandler: @escaping () -> Void) {
        let context = persistentContainer.viewContext
        context.perform {
            do {
                _ = try users.map { try UsersEntity.findeOrCreate(user: $0, context: context) }
                try context.save()
                completionHandler()
            } catch {
                print("Error saving Users in CoreData: \(error)")
            }
        }
    }
    
    func update(user: UsersModel, completionHandler: @escaping (UsersEntity) -> Void) {
        
        let context = persistentContainer.viewContext
        context.perform {
            do {
                if let found = try UsersEntity.findAndUpdate(entity: UsersEntity.self, searchType: .id(user.id), context: context),
                    let entity = found as? UsersEntity {
                    completionHandler(entity)
                    try context.save()
                }
            } catch {
                print("Error update Users in CoreData: \(error)")
            }
        }
    }
    
    func deleteUser(byId: Int, completionHandler: @escaping () -> Void) {
        
        let context = persistentContainer.viewContext
        context.perform {
            do {
                if let found = try UsersEntity.findAndUpdate(entity: UsersEntity.self, searchType: .id(byId), context: context),
                   let entity = found as? UsersEntity {
                    context.delete(entity)
                    try context.save()
                    completionHandler()
                }
            } catch {
                print("Error delete Users in CoreData: \(error)")
            }
        }
    }
    
    // MARK: - Posts
    
    func getStoragePosts(byUserId: Int, completionHandler: @escaping ([PostsModel]) -> Void) {
        let context = persistentContainer.viewContext
        context.perform {
            
            do {
                let fetchPostsEntities = try PostsEntity.fetchPostBy(userId: byUserId, context: context)
                let posts = fetchPostsEntities.map {PostsModel(entity: $0)}
                completionHandler(posts)
            } catch {
                print("Failed to load Posts: \(error)")
            }
        }
    }
    
    func getAllPosts(completionHandler: @escaping ([PostsModel]) -> Void) {
        let context = persistentContainer.viewContext
        context.perform {
            do {
                let fetchPostsEntities = try PostsEntity.fetchAllPosts(context: context)
                let fetched = fetchPostsEntities.map { PostsModel(entity: $0) }
                completionHandler(fetched)
            } catch {
                print("Failed to load Posts: \(error)")
            }
        }
    }
    
    func save(posts: [PostsModel], completionHandler: @escaping () -> Void) {
        let contex = persistentContainer.viewContext
        contex.perform {
            
            do {
                _ = try posts.map { try PostsEntity.findOrCreate(post: $0, context: contex) }
                try contex.save()
                completionHandler()
            } catch {
                print("Error saving Posts in CoreData: \(error)")
            }
        }
    }
    
    // MARK: - Comments
    
    func getStorageComments(byPostsId: Int, completionHandler: @escaping ([CommentsModel]) -> Void) {
        let context = persistentContainer.viewContext
        context.perform {
            do {
                let fetchComments = try CommentsEntity.fetchCommentsBy(postId: byPostsId, context: context)
                let comments = fetchComments.map { CommentsModel(entities: $0) }
                completionHandler(comments)
            } catch {
                print("Failed to load Comments: \(error)")
            }
        }
    }
    
    
    func save(comments: [CommentsModel], completionHandler: @escaping () -> Void) {
        let context = persistentContainer.viewContext
        context.perform {
            do {
                _ = try comments.map { try CommentsEntity.findOrCreate(comments: $0, context: context) }
                try context.save()
                completionHandler()
            } catch {
                print("Error saving Comments in CoreData: \(error)")
            }
        }
    }
}

