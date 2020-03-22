//
//  SecondVC.swift
//  TeskTaskWorkWithNetwork
//
//  Created by Максим Окунеев on 2/19/20.
//  Copyright © 2020 Максим Окунеев. All rights reserved.
//

import UIKit

class PhotosVC: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    
    var albumsIDs = [Int]()
    private var photos = [Photos]()
    private var filteredPhotos = [Photos]()
    let memoryCapacity = 500 * 1024 * 1024
    let diskCapacity = 500 * 1024 * 1024
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlCache = URLCache(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity, diskPath: "diskPath")
        URLCache.shared = urlCache
        fetchPhotosData()
    }
    
    // MARK: Network
    private func fetchPhotosData() {
        
        NetworkService.fetchPhotosData() { (jsonData) in
            self.photos = jsonData
            for index in 0..<self.albumsIDs.count {
                self.filteredPhotos += self.photos.filter{ $0.albumId == self.albumsIDs[index]}
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

// MARK: TableViewDataSource

extension PhotosVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPhotos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "photosVCCell", for: indexPath) as! PhotosTableViewCell
        let photo = filteredPhotos[indexPath.row]
        cell.configure(with: photo)
        
        let borderColor: UIColor =  .init(red: 240/256, green: 240/256, blue: 240/256, alpha: 1)
        cell.photoFrontView.layer.borderColor = borderColor.cgColor
        
        return cell
    }
}
