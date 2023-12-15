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
    
    init(entity: PostsEntity) {
        self.userId = Int(entity.userId)
        self.id = Int(entity.id)
        self.title = entity.title ?? ""
        self.body = entity.body ?? ""
    }
}
