//
//  UsersResponce.swift
//  TeskTaskWorkWithNetwork
//
//  Created by Максим Окунеев on 2/19/20.
//  Copyright © 2020 Максим Окунеев. All rights reserved.
//

import Foundation

struct GetUserResponse {
    typealias JSON = [String: AnyObject]
    let users: [UsersModel]
    init(json: Any) throws {
        guard let array = json as? [JSON] else { throw NetworkError.failInternetError}
        
        var users = [UsersModel]()
        for dictionary in array {
            guard let user = UsersModel(dict: dictionary) else { continue }
            users.append(user)
        }
        print(users.count)
        self.users = users
    }
}
