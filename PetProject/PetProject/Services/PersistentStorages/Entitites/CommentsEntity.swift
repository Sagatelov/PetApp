//
//  CommentsEntitiy.swift
//  PetProject
//
//  Created by Andrew Sagatelov on 05.12.2023.
//

import Foundation
import CoreData

final class CommentsEntity: NSManagedObject, FindEntities {
    
    static func fetchCommentsBy(postId: Int, context: NSManagedObjectContext) throws -> [CommentsEntity] {
        let recuest = CommentsEntity.fetchRequest()
        recuest.predicate = NSPredicate(format: "postId = %d", postId)
        
        do {
            let fetchComments = try context.fetch(recuest)
            return fetchComments
        } catch {
            throw error
        }
    }
    
    
    static func findOrCreate(comments: CommentsModel, context: NSManagedObjectContext) throws -> CommentsEntity? {
        
        let request = CommentsEntity.fetchRequest()
        
        do {
            if let findCommentsEntity = try CommentsEntity.findEntitybyid(byId: comments.id,
                                                                      context: context,
                                                                      request: request) {
                return findCommentsEntity
                
            } else {
                
                let requestPostsEntity = PostsEntity.fetchRequest()
                if let postExist = try PostsEntity.findEntitybyid(byId: comments.postId,
                                                              context: context,
                                                              request: requestPostsEntity) {
                    let createComment = CommentsEntity(context: context)
                    createComment.body = comments.body
                    createComment.email = comments.email
                    createComment.name = comments.name
                    createComment.id = Int64(comments.id)
                    createComment.postId = Int64(comments.postId)
                    createComment.post = postExist
                    return createComment
                }
            }
            
        } catch {
            throw error
        }
        
        return nil
    }
    
}

