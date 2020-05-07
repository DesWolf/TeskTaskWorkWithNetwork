//
//  NetworkManager.swift
//  TeskTaskWorkWithNetwork
//
//  Created by Максим Окунеев on 2/19/20.
//  Copyright © 2020 Максим Окунеев. All rights reserved.
//

import UIKit

protocol AlertNetworkProtocol: AnyObject {
    func alertNetwork()
}

struct NetworkService {
    
    weak var delegate: AlertNetworkProtocol?
    
    // MARK: Network
    func fetchUsersData(completion: @escaping ([Users]) -> ()) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { return }
        URLSession.shared.dataTask(with: url) { (data, responce, error) in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let jsonData = try decoder.decode([Users].self, from: data)
                    DispatchQueue.main.async {
                        completion(jsonData)
                    }
                } catch let error {
                    DispatchQueue.main.async {
                        print ("Error serialization JSON", error)
                        completion([])
                    }
                }
            } else {
                self.delegate?.alertNetwork()
            }
        }.resume()
    }
    
    func fetchAlbumsData(completion: @escaping ([Albums]) -> ()) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/albums") else { return }
        URLSession.shared.dataTask(with: url) { (data, responce, error) in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let jsonData = try decoder.decode([Albums].self, from: data)
                    completion(jsonData)
                } catch let error {
                    print ("Error serialization JSON", error)
                    DispatchQueue.main.async {
                        completion([])
                    }
                }
            } else {
                self.delegate?.alertNetwork()
            }
        }.resume()
    }
    
    func fetchPhotosData(completion: @escaping ([Photos]) -> ()) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/photos") else { return }
        URLSession.shared.dataTask(with: url) { (data, responce, error) in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let jsonData = try decoder.decode([Photos].self, from: data)
                    DispatchQueue.main.async {
                        completion(jsonData)
                    }
                } catch let error {
                    DispatchQueue.main.async {
                        print ("Error serialization JSON", error)
                        completion([])
                    }
                }
            } else {
                self.delegate?.alertNetwork()
            }
        }.resume()
    }
    
    
    func fetchImage(imageUrl: String, completion: @escaping (UIImage) -> ()){
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            guard let imageUrl = URL(string: imageUrl) else { return }
            let session = URLSession.shared
            session.dataTask(with: imageUrl) { (data, response, error) in
                
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        completion(image)
                    }
                } else {
                    DispatchQueue.main.async {
                        self.delegate?.alertNetwork()
                        let image = #imageLiteral(resourceName: "noImage")
                        completion(image)
                    }
                }
            }.resume()
        }
    }
}
