//
//  CommentsModel.swift
//  PetProject
//
//  Created by Andrew Sagatelov on 04.12.2023.
//

import Foundation
class CommentsModel: Codable {
    var postId: Int
    var id: Int
    var name: String
    var email: String
    var body: String
}
