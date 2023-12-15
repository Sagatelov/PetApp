//
//  HelpersProtocols.swift
//  PetProject
//
//  Created by Andrew Sagatelov on 13.12.2023.
//

import Foundation
import CoreData

//MARK: - check if the entities allready exist

protocol FindEntities {
    static func findEntity<EntityName>(byId: Int, context: NSManagedObjectContext, recuest: NSFetchRequest<EntityName>) throws -> EntityName?
}

extension FindEntities {
    
    static func findEntity<EntityName>(byId: Int, context: NSManagedObjectContext, recuest: NSFetchRequest<EntityName>) throws -> EntityName? {
        
        recuest.predicate = NSPredicate(format: "id == %d", byId)
        
        do {
            let fetch = try context.fetch(recuest)
            if fetch.count > 0 {
                assert(fetch.count == 1, "Dublicate has been found in DB!")
                return fetch[0]
            }
        } catch {
            throw error
        }
        return nil
    }
}
