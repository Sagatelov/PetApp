//
//  Model.swift
//  PetProject
//
//  Created by Andrew Sagatelov on 02.12.2023.
//

import Foundation

struct UsersModel: Codable {
    var id: Int
    let name: String
    let username: String
    let email: String
    let address: UserAddressInfo?
    let phone: String?
    let website: String?
    let company: UserCompanyInfo?
    
    init(entity: UsersEntity) {
        self.id = Int(entity.id)
        self.name = entity.name ?? ""
        self.username = entity.username ?? ""
        self.email = entity.email ?? ""
        self.address = nil
        self.phone = nil
        self.website = nil
        self.company = nil
    }
    
    init(newName name: String, newNick username: String, newEmail email: String) {
        let geo = UserGeoInfo(lat: "", lng: "")
        let address = UserAddressInfo(street: "", suite: "", city: "", zipcode: "", geo: geo)
        let companyInfo = UserCompanyInfo(name: "", catchPhrase: "", bs: "")
        
        self.id = 0
        self.name = name
        self.username = username
        self.email = email
        self.address = address
        self.phone = ""
        self.website = ""
        self.company = companyInfo
    }
}

struct UserAddressInfo: Codable {
    let street: String
    let suite: String
    let city: String
    let zipcode: String
    let geo: UserGeoInfo
}

struct UserGeoInfo: Codable {
    let lat: String
    let lng: String
}

struct UserCompanyInfo: Codable {
    let name: String
    let catchPhrase: String
    let bs: String
}
