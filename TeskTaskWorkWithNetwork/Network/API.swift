//
//  API.swift
//  TeskTaskWorkWithNetwork
//
//  Created by Максим Окунеев on 2/20/20.
//  Copyright © 2020 Максим Окунеев. All rights reserved.
//

import Foundation

struct Api {
    
   static func currentUrl(identifier: String) -> String {
        
        var url = ""
        
        switch identifier {
            case "users":
                url = "https://jsonplaceholder.typicode.com/users"
            case "albums":
                url = "https://jsonplaceholder.typicode.com/albums"
            case "photos":
                url = "https://jsonplaceholder.typicode.com/photos"
            default:
                 url = ""
        }
            return url
        }
}
