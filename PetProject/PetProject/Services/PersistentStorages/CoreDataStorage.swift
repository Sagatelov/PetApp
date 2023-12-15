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
    
    // MARK: - save and fetch metod for User
    
    func getStorageUsers(complitionHandler: @escaping ([UsersModel]) -> Void) {
        
        let context = persistentContainer.viewContext
        context.perform {
            do{
                let fetchUsersEntities = try UsersEntity.fetchUserEntities(context: context)
                let users = fetchUsersEntities.map {UsersModel(entity: $0)}
                complitionHandler(users)
            } catch {
                print("Не удалось загрузить всех Users: \(error)")
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
                print("Ошибка сохранения Users в CoreData: \(error)")
            }
        }
        
    }
}
