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
    
    private var users = [Users]()
    private var albums = [Albums]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUsersData()

        self.tableView.tableFooterView = UIView()
    }
    
    @IBAction func updateUsers(_ sender: Any) {
        fetchUsersData()
    }
}

// MARK: Network
extension UsersVC {
    private func fetchUsersData() {
        NetworkService.fetchUsersData() { (jsonData) in
            self.users = jsonData
            self.fetchAlbumsData()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private func fetchAlbumsData() {
        NetworkService.fetchAlbumsData() { (jsonData) in
            self.albums = jsonData
            
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
            let filterAlbums = albums.filter{ $0.userId == user.id }
            photosVC.albumsIDs = filterAlbums.compactMap { $0.id }
        }
    }
}

// MARK: TableViewDataSource

extension UsersVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }

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
