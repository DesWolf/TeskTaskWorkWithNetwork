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
    private var photos = [PhotoInfo]()
    private var filteredPhotos = [PhotoInfo]()
    private let networkManagerMainData = NetworkManagerMainData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPhotosData()
    }
}

// MARK: Network
extension PhotosVC {
    private func fetchPhotosData() {
        for elem in 0..<(albumsIDs.count) {
            networkManagerMainData.fetchPhotosData(albumId: elem) { [weak self] (photoInfo, error) in
                guard let photoInfo = photoInfo else {
                    print(error ?? "")
                    DispatchQueue.main.async {
                        self?.alertNetwork(message: error ?? "")
                    }
                    return
                }
                self?.filteredPhotos += photoInfo
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
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

//MARK: Alert
extension PhotosVC {
    func alertNetwork(message: String) {
        print("AlertinVC")
        UIAlertController.alert(title:"Error", msg:"\(message)", target: self)
    }
}
