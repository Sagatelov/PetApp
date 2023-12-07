//
//  PostsModel.swift
//  PetProject
//
//  Created by Andrew Sagatelov on 04.12.2023.
//

import Foundation

struct PostsModel: Codable {
    var userId: Int
    var id: Int
    var title: String
    var body: String
    
    init(postEntity: PostsEntity) {
        self.userId = Int(postEntity.userId)
        self.id = Int(postEntity.id)
        self.title = postEntity.title ?? ""
        self.body = postEntity.body ?? ""
    }
}
