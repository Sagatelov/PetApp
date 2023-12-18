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
    
    
    // MARK: - save and fetch for User
    
    func getStorageUsers(completionHandler: @escaping ([UsersModel]) -> Void) {
        
        let context = persistentContainer.viewContext
        context.perform {
            do {
                let fetchUsersEntities = try UsersEntity.fetchUserEntities(context: context)
                let users = fetchUsersEntities.map {UsersModel(entity: $0)}
                completionHandler(users)
            } catch {
                print("Failed to load all Users: \(error)")
            }
        }
    }
    
    func save(users: [UsersModel], complitonHandler: @escaping () -> Void) {
        let context = persistentContainer.viewContext
        context.perform {
            do {
                for user in users {
                    _ = try UsersEntity.findeOrCreate(user: user, context: context)
                }
                try context.save()
                complitonHandler()
            } catch {
                print("Error saving Users in CoreData: \(error)")
            }
        }
        
    }
    
    // MARK: - save and fetch for Posts
    
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
    
    func save(posts: [PostsModel], completionHandler: @escaping () -> Void) {
        let contex = persistentContainer.viewContext
        contex.perform {
            
            do {
                for post in posts {
                    _ = try PostsEntity.findOrCreate(post: post, context: contex)
                }
                try contex.save()
                completionHandler()
            } catch {
                print("Error saving Posts in CoreData: \(error)")
            }
        }
    }
    
    // MARK: - save and fatch for Comments
    
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
                for comment in comments {
                    _ = try CommentsEntity.findOrCreate(comments: comment, context: context)
                }
                try context.save()
                completionHandler()
            } catch {
                print("Error saving Comments in CoreData: \(error)")
            }
        }
    }
    
}
