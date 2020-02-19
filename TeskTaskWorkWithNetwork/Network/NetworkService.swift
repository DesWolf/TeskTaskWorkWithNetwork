//
//  NetworkManager.swift
//  TeskTaskWorkWithNetwork
//
//  Created by Максим Окунеев on 2/19/20.
//  Copyright © 2020 Максим Окунеев. All rights reserved.
//

class NetworkService {
    
    private init() {}
    static let shared = NetworkService()
    
    public func getData( url: URL, comlection: @escaping (Any) -> ()) {
        let session = URLSession.shared
        
        session.dataTask(with: url) { (data, response, error) in
            guard let data = data  else { return }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                DispatchQueue.main.async {
                    comlection(json)
                }
            } catch  {
                print(error)
            }
        }.resume()
    }
}
