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
    
//    init?(dict: [String : AnyObject]) {
//        guard let id = dict["id"] as? Int,
//            let name = dict["name"] as? String,
//            let userName = dict["username"] as? String,
//            let email = dict["email"] as? String,
//            let address = dict["address"] as? Address,
//            let phone = dict["phone"] as? String,
//            let website = dict["website"] as? String,
//            let company = dict["company"] as? Company else { return nil }
//
//        self.id = id
//        self.name = name
//        self.username = userName
//        self.email = email
//        self.address = address
//        self.phone = phone
//        self.website = website
//        self.company = company
//    }
}

struct Address: Decodable {
    let street: String?
    let suite: String?
    let city: String?
    let zipcode: String?
    let geo: Geo?
    
//    init?(dict: [String : AnyObject]) {
//        guard let street = dict["street"] as? String,
//            let suite = dict["suite"] as? String,
//            let city = dict["city"] as? String,
//            let zipcode = dict["zipcode"] as? String,
//            let geo = dict["geo"] as? Geo else { return nil }
//
//        self.street = street
//        self.suite = suite
//        self.city = city
//        self.zipcode = zipcode
//        self.geo = geo
//
//}
}

struct Geo: Decodable {
    let lat: String?
    let lng: String?
    
//    init?(dict2: [String : AnyObject]) {
//        guard let lat = dict2["lat"] as? String,
//            let lng = dict2["lng"] as? String, else { return nil }
//
//        self.lat = lat
//        self.lng = lng
//    }
}

struct Company: Decodable {
   
    let name: String?
    let catchPhrase: String?
    let bs: String?
    
//    init?(dict3: [String : AnyObject]) {
//    guard let name = dict3["name"] as? String,
//        let catchPhrase = dict3["catchPhrase"] as? String,
//        let bs = dict3["bs"] as? String, else { return nil }
//
//    self.name = name
//    self.catchPhrase = catchPhrase
//    self.bs = bs
//
//}
}

