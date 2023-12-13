//
//  UsersEntity.swift
//  PetProject
//
//  Created by Andrew Sagatelov on 05.12.2023.
//

import Foundation
import CoreData

class UsersEntity: NSManagedObject, FindEntities {
    
    static func getAllUserEntities(context: NSManagedObjectContext) throws -> [UsersEntity] {
        
        let recuest = UsersEntity.fetchRequest()
        
        do {
            let FetchUsers = try context.fetch(recuest)
            return FetchUsers
        } catch {
            throw error
        }
    }
    
    
    static func findeOrCreate(user: UsersModel, context: NSManagedObjectContext) throws -> UsersEntity {
        
        let recuest = UsersEntity.fetchRequest()
        
        do {
            if let findeUserEntity = try findEntity(byId: user.id, context: context, recuest: recuest) {
                return findeUserEntity
            } else {
                let createUser = UsersEntity(context: context)
                createUser.id = Int64(user.id)
                createUser.name = user.name
                createUser.username = user.username
                createUser.email = user.email
                return createUser
            }
        } catch {
            throw error
        }
    }
    
}
