//
//  NetworkManager.swift
//  TeskTaskWorkWithNetwork
//
//  Created by Максим Окунеев on 2/19/20.
//  Copyright © 2020 Максим Окунеев. All rights reserved.
//

import Foundation


class NetworkService {
    
     static func fetchData(identifier: String, completion: @escaping (Any) -> ()) {
        
        guard let url = URL(string: Api.currentUrl(identifier: identifier)) else { return }
        
            URLSession.shared.dataTask(with: url) { (data, responce, error) in
                guard let data = data else { return }
                do {
                    let decoder = JSONDecoder()
                    switch identifier {
                    case "users":
                        let jsonData = try decoder.decode([UsersModel].self, from: data)
                        completion(jsonData)
                    case "albums":
                        let jsonData = try decoder.decode([AlbumsModel].self, from: data)
                        completion(jsonData)
                    case "photos":
                        let jsonData = try decoder.decode([PhotosModel].self, from: data)
                        completion(jsonData)
                    default:
                        break
                    }

                } catch let error {
                    print ("Error serialization JSON", error)
                }
            }.resume()
        }
}

