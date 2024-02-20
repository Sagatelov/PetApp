//
//  UsersEntity.swift
//  PetProject
//
//  Created by Andrew Sagatelov on 05.12.2023.
//

import Foundation
import CoreData

final class UsersEntity: NSManagedObject, FindEntities {
    
    static func fetchUserEntities(context: NSManagedObjectContext) throws -> [UsersEntity] {
        let rquest = UsersEntity.fetchRequest()
        
        do {
            let FetchUsers = try context.fetch(rquest)
            return FetchUsers
        } catch {
            throw error
        }
    }
    
    
    static func findeOrCreate(user: UsersModel, context: NSManagedObjectContext) throws -> UsersEntity {
        
        let request = UsersEntity.fetchRequest()
        
        do {
            if let findeUserEntity = try findEntitybyid(byId: user.id, 
                                                    context: context,
                                                    request: request) {
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
