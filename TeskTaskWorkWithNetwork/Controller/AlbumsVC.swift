//
//  AlbumVC.swift
//  TeskTaskWorkWithNetwork
//
//  Created by Максим Окунеев on 2/20/20.
//  Copyright © 2020 Максим Окунеев. All rights reserved.
//

import Foundation

class AlbumsVC {
    
    var albums = [AlbumsModel]()

    func fetchData(identifier: String) {

        let queue = DispatchQueue.global(qos: .background)
        queue.async {
                  
            NetworkService.fetchData(identifier: identifier) { (albums) in
                  
                DispatchQueue.main.async {
                self.albums = albums as! [AlbumsModel]
                }
            }
        }
    }
 

    
//    func selectedAlbums(albums: [AlbumsModel]) -> [Int]{
//        
//        var result:[Int] = []
//        
//        for elem in 0..<albums.count {
//            
//            result.append(albums[elem][id])
//        
//        }
//        return result
//    }
}

