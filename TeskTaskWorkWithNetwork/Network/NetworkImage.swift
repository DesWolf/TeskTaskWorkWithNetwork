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
            DispatchQueue.main.async {
                completion(image)
            }
        }
    }.resume()
    }
}
//
//let url:URL! = URL(string: artworkUrl)
//task = session.downloadTask(with: url, completionHandler: { (location, response, error) -> Void in
//    if let data = try? Data(contentsOf: url){
//        // 4
//        DispatchQueue.main.async(execute: { () -> Void in
//            // 5
//            // Before we assign the image, check whether the current cell is visible
//            if let updateCell = tableView.cellForRow(at: indexPath) {
//                let img:UIImage! = UIImage(data: data)
//                updateCell.imageView?.image = img
//                self.cache.setObject(img, forKey: (indexPath as NSIndexPath).row as AnyObject)
//            }
//        })
//    }
//})
//task.resume()
