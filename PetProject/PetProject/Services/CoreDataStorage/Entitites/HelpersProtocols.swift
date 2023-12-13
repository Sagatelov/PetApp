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
    static func findEntity<T>(byId: Int, context: NSManagedObjectContext, recuest: NSFetchRequest<T>) throws -> T?
}

extension FindEntities {
    
    static func findEntity<T>(byId: Int, context: NSManagedObjectContext, recuest: NSFetchRequest<T>) throws -> T? {
        
        recuest.predicate = NSPredicate(format: "id == %d", byId)
        
        do {
            let fetchUser = try context.fetch(recuest)
            if fetchUser.count > 0 {
                assert(fetchUser.count == 1, "Dublicate has been found in DB!")
                return fetchUser[0]
            }
        } catch {
            throw error
        }
        return nil
    }
}
