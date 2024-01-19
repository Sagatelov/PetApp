//
//  Valdation.swift
//  PetProject
//
//  Created by Andrew Sagatelov on 06.01.2024.
//

import Foundation

final class Validation {
    static func emailValidation(email: String) -> Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let predicat = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicat.evaluate(with: email)
    }
}
