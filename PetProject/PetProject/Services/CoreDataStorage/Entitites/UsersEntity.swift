//
//  UsersEntity.swift
//  PetProject
//
//  Created by Andrew Sagatelov on 05.12.2023.
//

import Foundation
import CoreData

class UsersEntity: NSManagedObject {
    
    static func getAllUserEntities(context: NSManagedObjectContext) throws -> [UsersEntity] {
        
        let recuest = UsersEntity.fetchRequest()
        
        do {
            let getAllFetch = try context.fetch(recuest)
            return getAllFetch
        } catch {
            throw error
        }
    }
    
    
    static func create(users: UsersModel, context: NSManagedObjectContext) throws -> UsersEntity {
        
        do {
            if let user = try findUsers(byId: users.id, context: context) {
                return user
            } else {
                let createUser = UsersEntity(context: context)
                createUser.id = Int64(users.id)
                createUser.name = users.name
                createUser.username = users.username
                createUser.email = users.email
                return createUser
            }
        } catch {
            throw error
        }
    }
    
    
    static func findUsers(byId: Int, context: NSManagedObjectContext) throws -> UsersEntity? {
        
        let recuest = UsersEntity.fetchRequest()
        recuest.predicate = NSPredicate(format: "id = %id", byId)
        
        do {
            let recuestResult = try context.fetch(recuest)
            if recuestResult.count > 0 {
                assert(recuestResult.count == 1, "Dublicate has been found in DB!")
                return recuestResult[0]
            }
        } catch {
            throw error
        }
        return nil
    }
    
    
}
