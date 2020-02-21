//
//  NetworkImage.swift
//  TeskTaskWorkWithNetwork
//
//  Created by Максим Окунеев on 2/21/20.
//  Copyright © 2020 Максим Окунеев. All rights reserved.
//

import UIKit

class NetworkImage {
    
    static func fetchImage(imageUrl: String, completion: @escaping (Any) -> ()){
    print(imageUrl)

    guard let imageUrl = URL(string: imageUrl) else { return }

    let session = URLSession.shared
    session.dataTask(with: imageUrl) { (data, response, error) in
        
        if let data = data, let image = UIImage(data: data) {
//            DispatchQueue.main.async {
////                self.hotelImage.image = self.supportFunc.cropImage2(image: image)
////                self.activityIndicatorView.stopAnimating()
                completion(image)
//            }
//        }
    }
    }.resume()
    }
}
