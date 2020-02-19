//
//  NetworkManager.swift
//  TeskTaskWorkWithNetwork
//
//  Created by Максим Окунеев on 2/19/20.
//  Copyright © 2020 Максим Окунеев. All rights reserved.
//

import Foundation

enum NetworkEnvironment: String {
    case users
    case albums
    case photos
}


class NetworkService {
    
        static let url = ""
    
     static func fetchData(url: String, identifier: String, completion: @escaping (Any) -> ()) {
        
            guard let url = URL(string: url) else { return }
            URLSession.shared.dataTask(with: url) { (data, responce, error) in
                guard let data = data else { return }
                do {
                    let decoder = JSONDecoder()
                    let jsonData = try decoder.decode([UsersModel].self, from: data)
                    completion(jsonData)
                } catch let error {
                    print ("Error serialization JSON", error)
                }
            }.resume()
        }
}

extension NetworkEnvironment {
    switch NetworkService. {
        case users:
            let url = "https://jsonplaceholder.typicode.com/users"
        case albums:
            let url = "https://jsonplaceholder.typicode.com/albums"
        case photos:
            let url = "https://jsonplaceholder.typicode.com/photos"
    }
}
