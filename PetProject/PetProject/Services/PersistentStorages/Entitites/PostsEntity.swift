//
//  PostsEntity.swift
//  PetProject
//
//  Created by Andrew Sagatelov on 05.12.2023.
//

import Foundation
import CoreData

final class PostsEntity: NSManagedObject, FindEntities {
    
    static func fetchPostsEntities(context: NSManagedObjectContext) throws -> [PostsEntity] {
        
        let recuest = PostsEntity.fetchRequest()
        
        do {
            let FetchPosts = try context.fetch(recuest)
            return FetchPosts
        } catch {
            throw error
        }
    }
    
    
    static func findOrCreate(post: PostsModel, context: NSManagedObjectContext ) throws -> PostsEntity? {
        
        let request = PostsEntity.fetchRequest()
        
        do {
            if let findePostEntity = try PostsEntity.findEntity(byId: post.id,
                                                                context: context,
                                                                recuest:request) {
                return findePostEntity
                
            } else {
                
                //create PostEntyty only if exist the UserEntity
                let recuestUserEntity = UsersEntity.fetchRequest()
                if let userEntity = try UsersEntity.findEntity(byId: post.userId,
                                                               context: context,
                                                               recuest: recuestUserEntity) {
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