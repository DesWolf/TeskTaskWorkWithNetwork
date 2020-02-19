//
//  usersModel.swift
//  TeskTaskWorkWithNetwork
//
//  Created by Максим Окунеев on 2/19/20.
//  Copyright © 2020 Максим Окунеев. All rights reserved.
//

import Foundation

struct UsersModel: Decodable {
    
    let id: Int?
    let name: String?
    let username: String?
    let email: String?
    let address: Address?
    let phone: String?
    let website: String?
    let company: Company?
    
    init?(dict: [String : AnyObject]) {
        guard let id = dict["id"] as? Int,
            let name = dict["name"] as? String,
            let userName = dict["username"] as? String,
            let email = dict["email"] as? String,
            let address = dict["address"] as? Address,
            let phone = dict["phone"] as? String,
            let website = dict["website"] as? String,
            let company = dict["company"] as? Company else { return nil }
    
        self.id = id
        self.name = name
        self.username = userName
        self.email = email
        self.address = address
        self.phone = phone
        self.website = website
        self.company = company
    }
}

struct Address: Decodable {
    let street: String?
    let suite: String?
    let city: String?
    let zipcode: String?
    let geo: Geo?
}

struct Geo: Decodable {
    let lat: String?
    let lng: String?
}

struct Company: Decodable {
    let name: String?
    let catchPhrase: String?
    let bs: String?
}

