//
//  CommentsEntitiy.swift
//  PetProject
//
//  Created by Andrew Sagatelov on 05.12.2023.
//

import Foundation
import CoreData

class CommentsEntity: NSManagedObject, FindEntities {
    
    static func getAllCommentsEntity(context: NSManagedObjectContext) throws -> [CommentsEntity] {
        
        let request = CommentsEntity.fetchRequest()
        
        do {
            let fetchComments = try context.fetch(request)
            return fetchComments
        } catch {
            throw error
        }
    }
    
    
    static func findeOrCreate(comments: CommentsModel, context: NSManagedObjectContext) throws -> CommentsEntity? {
        
        let recuest = CommentsEntity.fetchRequest()
        
        do {
            if let findCommentsEntity = try CommentsEntity.findEntity(byId: comments.id,
                                                                  context: context,
                                                                  recuest: recuest) {
                return findCommentsEntity
                
            } else {
                
                let recuestPostsEntity = PostsEntity.fetchRequest()
                if let postExist = try PostsEntity.findEntity(byId: comments.postId,
                                                              context: context,
                                                              recuest: recuestPostsEntity) {
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

