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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UsersNetworkService.getComments { (response) in
            self.users = response.users
            self.tableView.reloadData()
            
        }
        
    }
}

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
