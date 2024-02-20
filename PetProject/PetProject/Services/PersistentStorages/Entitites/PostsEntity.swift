//
//  PostsEntity.swift
//  PetProject
//
//  Created by Andrew Sagatelov on 05.12.2023.
//

import Foundation
import CoreData

final class PostsEntity: NSManagedObject, FindEntities {
    
    static func fetchPostBy(userId: Int, context: NSManagedObjectContext) throws -> [PostsEntity] {
        let request = PostsEntity.fetchRequest()
        request.predicate = NSPredicate(format: "userId = %d", userId)
        
        do {
            let fetchPosts = try context.fetch(request)
            return fetchPosts
        } catch {
            throw error
        }
    }
    
    
    static func findOrCreate(post: PostsModel, context: NSManagedObjectContext ) throws -> PostsEntity? {
        
        let request = PostsEntity.fetchRequest()
        
        do {
            if let findePostEntity = try PostsEntity.findEntitybyid(byId: post.id,
                                                                context: context,
                                                                request: request) {
                return findePostEntity
                
            } else {
                
                //create PostEntyty only if the UserEntity exist
                let recuestUserEntity = UsersEntity.fetchRequest()
                if let userEntity = try UsersEntity.findEntitybyid(byId: post.userId,
                                                               context: context,
                                                               request: recuestUserEntity) {
                    let createPosts = PostsEntity(context: context)
                    createPosts.body = post.body
                    createPosts.title = post.title
                    createPosts.userId = Int64(post.userId)
                    createPosts.id = Int64(post.id)
                    createPosts.user = userEntity
                    return createPosts
                }
            }
            
        } catch {
            throw error
        }
        return nil
    }
}
