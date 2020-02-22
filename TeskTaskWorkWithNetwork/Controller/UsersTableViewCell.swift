//
//  MainTableViewCell.swift
//  TeskTaskWorkWithNetwork
//
//  Created by Максим Окунеев on 2/19/20.
//  Copyright © 2020 Максим Окунеев. All rights reserved.
//

import UIKit

class UsersTableViewCell: UITableViewCell {

    @IBOutlet var userNameLabel: UILabel!
    
    func configere( with user: UsersModel) {
        self.userNameLabel.text = user.name
    }
}
