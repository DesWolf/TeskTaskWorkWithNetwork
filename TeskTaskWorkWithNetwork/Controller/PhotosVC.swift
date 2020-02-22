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
    
    var numberOfAlbums = [Int]()
//    var indexTableRow = 0
    private var photos = [PhotosModel]()
    private var filtredPhotos = [PhotosModel]()
       
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        tableView.estimatedRowHeight = 400
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
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "photosVCCell", for: indexPath) as! PhotosTableViewCell
        let photo = filtredPhotos[indexPath.row]
        cell.configere(with: photo)
        
        cell.frontView.layer.masksToBounds = true
        cell.frontView.layer.cornerRadius = 10
        cell.frontView.layer.borderWidth = 1

        let borderColor: UIColor =  .init(red: 240/256, green: 240/256, blue: 240/256, alpha: 1)
        cell.frontView.layer.borderColor = borderColor.cgColor
        
        return cell
    }
}
    
//extension UIView {
//    func makeShadow() {
//        self.layer.shadowColor = UIColor.black.cgColor
//        self.layer.shadowOpacity = 0.7
//        self.layer.shadowOffset = CGSizeZero
//        self.layer.shadowRadius = 5
//    }
//}
