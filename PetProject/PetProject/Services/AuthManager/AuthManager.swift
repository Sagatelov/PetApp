//
//  AuthManager.swift
//  PetProject
//
//  Created by Andrew Sagatelov on 28.01.2024.
//

import Foundation
import FirebaseAuth

protocol AuthManagerProtocol {
    func createUser(email: String, password: String, completion: @escaping (_ success: Bool) -> Void)
    func signIn(email: String, pass: String, completion: @escaping (_ success: Bool) -> Void)
}

class AuthManager: AuthManagerProtocol {
    func createUser(email: String, password: String, completion: @escaping (_ success: Bool) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) {(authResult, error) in
            if let user = authResult?.user {
                print(user)
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
    
    func signIn(email: String, pass: String, completion: @escaping (_ success: Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: pass) { (result, error) in
            if let error = error, let _ = AuthErrorCode.Code(rawValue: error._code) {
                completion(false)
            } else {
                completion(true)
            }
        }
    }
    
}
