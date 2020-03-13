//
//  NetworkManager.swift
//  TeskTaskWorkWithNetwork
//
//  Created by Максим Окунеев on 2/19/20.
//  Copyright © 2020 Максим Окунеев. All rights reserved.
//

import UIKit


struct NetworkService {
    
    static func fetchUsersData(completion: @escaping ([UsersModel]) -> ()) {
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { return }
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
    
    static func fetchAlbumsData(completion: @escaping ([AlbumsModel]) -> ()) {
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/albums") else { return }
        URLSession.shared.dataTask(with: url) { (data, responce, error) in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([AlbumsModel].self, from: data)
                completion(jsonData)
            } catch let error {
                print ("Error serialization JSON", error)
            }
        }.resume()
    }
    
    static func fetchPhotosData(completion: @escaping ([PhotosModel]) -> ()) {
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/photos") else { return }
        URLSession.shared.dataTask(with: url) { (data, responce, error) in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([PhotosModel].self, from: data)
                completion(jsonData)
            } catch let error {
                print ("Error serialization JSON", error)
            }
        }.resume()
    }
    
    static func fetchImage(imageUrl: String, completion: @escaping (Any) -> ()){
        
        guard let imageUrl = URL(string: imageUrl) else { return }
        let session = URLSession.shared
        session.dataTask(with: imageUrl) { (data, response, error) in
            
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    completion(image)
                }
            }
        }.resume()
    }
}
