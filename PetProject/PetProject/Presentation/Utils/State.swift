//
//  State.swift
//  PetProject
//
//  Created by Andrew Sagatelov on 11.01.2024.
//

import Foundation

enum State {
    case successString(String)
    case errorString(String)
    case successUser(UsersModel)
}
