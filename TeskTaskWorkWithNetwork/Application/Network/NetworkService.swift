//
//  NetworkManager.swift
//  TeskTaskWorkWithNetwork
//
//  Created by Максим Окунеев on 2/19/20.
//  Copyright © 2020 Максим Окунеев. All rights reserved.
//

import UIKit

struct NetworkService {
    
    // MARK: Network
    static func fetchUsersData(completion: @escaping ([Users]) -> ()) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { return }
        URLSession.shared.dataTask(with: url) { (data, responce, error) in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let jsonData = try decoder.decode([Users].self, from: data)
                    completion(jsonData)
                } catch let error {
                    print ("Error serialization JSON", error)
                    completion([])
                }
            } else {
                DispatchQueue.main.async {
                    networkAlert()
                }
            }
        }.resume()
    }
    
    static func fetchAlbumsData(completion: @escaping ([Albums]) -> ()) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/albums") else { return }
        URLSession.shared.dataTask(with: url) { (data, responce, error) in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let jsonData = try decoder.decode([Albums].self, from: data)
                    completion(jsonData)
                } catch let error {
                    print ("Error serialization JSON", error)
                    completion([])
                }
            } else {
                DispatchQueue.main.async {
                    networkAlert()
                }
            }
        }.resume()
    }
    
    static func fetchPhotosData(completion: @escaping ([Photos]) -> ()) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/photos") else { return }
        URLSession.shared.dataTask(with: url) { (data, responce, error) in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let jsonData = try decoder.decode([Photos].self, from: data)
                    completion(jsonData)
                } catch let error {
                    DispatchQueue.main.async {
                        print ("Error serialization JSON", error)
                        completion([])
                    }
                }
            } else {
                DispatchQueue.main.async {
                    networkAlert()
                }
            }
        }.resume()
    }
    
    static func fetchImage(imageUrl: String, completion: @escaping (UIImage) -> ()){
        guard let imageUrl = URL(string: imageUrl) else { return }
        let session = URLSession.shared
        session.dataTask(with: imageUrl) { (data, response, error) in
            
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    completion(image)
                }
            } else {
                DispatchQueue.main.async {
                    networkAlert()
                    let image = #imageLiteral(resourceName: "noImage")
                    completion(image)
                }
            }
        }.resume()
    }
    
    // MARK: Network Alert
    static func networkAlert() {
        let alertController = UIAlertController(title: "Error", message: "Network is unavaliable! Please try again later!", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        let rootViewController = UIApplication.shared.keyWindow?.rootViewController
        rootViewController?.present(alertController, animated: true, completion: nil)
    }
}
