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
    
    private init () { }
    
    // MARK: - save and fetch for User
    
    func getStorageUsers(complitionHandler: @escaping ([UsersModel]) -> Void) {
        
        let context = persistentContainer.viewContext
        context.perform {
            do{
                let fetchUsersEntities = try UsersEntity.fetchUserEntities(context: context)
                let users = fetchUsersEntities.map {UsersModel(entity: $0)}
                complitionHandler(users)
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
                    let result = try UsersEntity.findeOrCreate(user: user, context: context)
                }
                try context.save()
                complitonHandler()
            } catch {
                print("Error saving Users in CoreData: \(error)")
            }
        }
        
    }
    
    //MARK: - save and fetch for Posts
    
    func getStoragePosts(complitionHandler: @escaping ([PostsModel]) -> Void) {
        let context = persistentContainer.viewContext
        context.perform {
            
            do {
                let fetchPostsEntities = try PostsEntity.fetchPostsEntities(context: context)
                let posts = fetchPostsEntities.map {PostsModel(entity: $0)}
                complitionHandler(posts)
            } catch {
                print("Failed to load all Posts: \(error)")
            }
        }
    }
    
    func save(posts: [PostsModel], complitionHandler: @escaping () -> Void) {
        let contex = persistentContainer.viewContext
        contex.perform {
            
            do {
                for post in posts {
                    let result = try PostsEntity.findOrCreate(post: post, context: contex)
                }
                try contex.save()
                complitionHandler()
            } catch {
                print("Error saving Posts in CoreData: \(error)")
            }
        }
    }
    
}
