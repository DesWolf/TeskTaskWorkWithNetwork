//
//  ViewController.swift
//  TeskTaskWorkWithNetwork
//
//  Created by Максим Окунеев on 2/19/20.
//  Copyright © 2020 Максим Окунеев. All rights reserved.
//

import UIKit

class UsersVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var users = [UsersModel]()
    var albums = AlbumsVC()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        fetchData(identifier: "users")
        albums.fetchData(identifier: "albums")

    }
    
    func fetchData(identifier: String) {
        
        NetworkService.fetchData(identifier: identifier) { (users) in
            
            self.users = users as! [UsersModel]
           
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

 // MARK: Navigation
extension UsersVC {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          
        if segue.identifier == "photosVC" {
            
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let user = users[indexPath.row]
            let photosVC = segue.destination as! PhotosVC
            
            let filterAlbums = albums.albums.filter{ $0.userId == user.id }
            photosVC.numberOfAlbums = filterAlbums.compactMap { $0.id }
        }
    }
}

// MARK: TableViewDelagate & TableViewDataSource
extension UsersVC: UITableViewDelegate {
}

extension UsersVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "usersVCCell", for: indexPath) as! UsersTableViewCell
        
        let user = users[indexPath.row]
       
        cell.configere(with: user)
        return cell
    }
}
