//
//  CommentsModel.swift
//  PetProject
//
//  Created by Andrew Sagatelov on 04.12.2023.
//

import Foundation

struct CommentsModel: Codable {
    var postId: Int
    var id: Int
    var name: String
    var email: String
    var body: String
    
    init (entities: CommentsEntity) {
        self.postId = Int(entities.postId)
        self.id = Int(entities.id)
        self.name = entities.name ?? ""
        self.email = entities.email ?? ""
        self.body = entities.body ?? ""
    }
}
