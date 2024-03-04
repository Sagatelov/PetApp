//
//  HelpersProtocols.swift
//  PetProject
//
//  Created by Andrew Sagatelov on 13.12.2023.
//

import Foundation
import CoreData

//MARK: - check if the entities allready exist
enum SearchType {
    case email(String)
    case id(Int)
}

protocol FindEntities {}
extension FindEntities {
    
    static func findEntitybyEmail<EntityName>(byEmail: String,
                                              context: NSManagedObjectContext,
                                              request: NSFetchRequest<EntityName>)
    throws -> EntityName? {
        request.predicate = NSPredicate(format: "email == [c] %@", byEmail)
        
        do {
            let fetch = try context.fetch(request)
            if fetch.count > 0 {
                assert(fetch.count == 1, "Dublicate has been found in DB!")
                return fetch[0]
            }
        } catch {
            throw error
        }
        return nil
    }
    
    static func findEntitybyid<EntityName>(byId: Int,
                                           context: NSManagedObjectContext,
                                           request: NSFetchRequest<EntityName>)
    throws -> EntityName? {
        request.predicate = NSPredicate(format: "id == %d", byId)
        
        do {
            let fetch = try context.fetch(request)
            if fetch.count > 0 {
                assert(fetch.count == 1, "Dublicate has been found in DB!")
                return fetch[0]
            }
        } catch {
            throw error
        }
        return nil
    }
    
    static func findAndUpdate<Entity: NSManagedObject>(entity: Entity.Type,
                                                       searchType: SearchType,
                                                       context: NSManagedObjectContext)
    throws -> NSFetchRequestResult? {
        let request = entity.fetchRequest()
        
        do {
            switch searchType {
            case .email(let email):
                if let foundEmail = try findEntitybyEmail(byEmail: email, context: context, request: request) {
                    return foundEmail
                }
            case .id(let id):
                if let foundId = try findEntitybyid(byId: id, context:context, request: request) {
                    return foundId
                }
            }
        } catch {
            throw error
        }
        return nil
    }
}
