//
//  UserDefaultStorage.swift
//  PetProject
//
//  Created by Andrew Sagatelov on 26.02.2024.
//

import UIKit

final class UserDefaultStorage {
    
    private init() {}
    
    static private let userDefaultFavoritesKey = "FavoritesKey"

    
    static func saveFavorites(isActive: Bool, idKey: Int) {
        let id = "\(idKey)"
        UserDefaults.standard.set( isActive, forKey: userDefaultFavoritesKey + id)
    }
    
    static func loadFavorites(idKey: Int) -> Bool {
        let id = "\(idKey)"
        return UserDefaults.standard.bool(forKey: userDefaultFavoritesKey + id)
    }
}
