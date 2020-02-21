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
    
    var numberOfAlbums = [Int]()
    private var photos = [PhotosModel]()
    private var filtredPhotos = [PhotosModel]()
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        fetchData(identifier: "photos")
    }
    
    func fetchData(identifier: String) {
           
            NetworkService.fetchData(identifier: identifier) { (photos) in
                self.photos = photos as! [PhotosModel]
                
               
                for index in 0..<self.numberOfAlbums.count {
                    self.filtredPhotos += self.photos.filter{ $0.albumId == self.numberOfAlbums[index]}
                }
                
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
        return filtredPhotos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
       // if indexPath.row == self.filtredPhotos.count {
        let cell = tableView.dequeueReusableCell(withIdentifier: "photosVCCell", for: indexPath) as! PhotosTableViewCell
        
        let photo = filtredPhotos[indexPath.row]
        cell.configere(with: photo)
        return cell
        
        
    }
    }
    

