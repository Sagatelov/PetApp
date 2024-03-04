//
//  Valdation.swift
//  PetProject
//
//  Created by Andrew Sagatelov on 06.01.2024.
//

import Foundation

final class Validation {
    
    enum ValidType: String {
        case email = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        case digits = ".*[0-9]+.*"
        case lowercase = ".*[a-z]+.*"
        case uppercase = ".*[A-Z]+.*"
        case name = "^[a-zA-Z0-9]{3,16}$"
        case nick = "^[a-zA-Z0-9_-]{3,16}$"
    }
    
    
    static func validation(type: ValidType, data: String) -> Bool {
        let regex = type.rawValue
        let predicat = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicat.evaluate(with: data)
    }
}
