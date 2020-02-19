//
//  UserNetworkService.swift
//  TeskTaskWorkWithNetwork
//
//  Created by Максим Окунеев on 2/19/20.
//  Copyright © 2020 Максим Окунеев. All rights reserved.
//

import Foundation

class UsersNetworkService {
    
    private init () {}
    
    static func getComments(completion: @escaping(GetUserResponse) -> ()) {
        guard let url = URL( string: "https://jsonplaceholder.typicode.com/users") else { return }
        
        NetworkService.shared.getData(url: url) {(json) in
            do {
                let response = try GetUserResponse(json: json)
                completion(response)
            } catch {
                print(error)
            }
        }
    }
}
