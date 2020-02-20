//
//  SecondVC.swift
//  TeskTaskWorkWithNetwork
//
//  Created by Максим Окунеев on 2/19/20.
//  Copyright © 2020 Максим Окунеев. All rights reserved.
//

import UIKit

class PhotosVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var filtredAlbums = [AlbumsModel]()
    var photos = [PhotosModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self

      // print(self.filtredAlbums.compactMap { $0.id })
        fetchData(identifier: "photos")
    }
    
    func fetchData(identifier: String) {
           
            NetworkService.fetchData(identifier: identifier) { (photos) in
                self.photos = photos as! [PhotosModel]
                
                let numberOfAlbums = self.filtredAlbums.compactMap { $0.id }

//                for index in 0..<numberOfAlbums.count {
//                    filtredPhotos.append(self.photos.filter{ $0.albumId == numberOfAlbums[index]})
//                }
//                print(filtredPhotos)
            
               DispatchQueue.main.async {
                   self.tableView.reloadData()
               }
           }
       }

}

// MARK: TableViewDelagate & TableViewDataSource
extension PhotosVC: UITableViewDelegate {
}

extension PhotosVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "photosVCCell", for: indexPath) as! PhotosTableViewCell
        
        if photos[indexPath.row].albumId == 1 {
            let photo = photos[indexPath.row]

        cell.configere(with: photo)
        }
        return cell
        
    }
    
    
}
