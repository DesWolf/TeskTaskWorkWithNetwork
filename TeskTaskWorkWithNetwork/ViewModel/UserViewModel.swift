//
//  UserViewModel.swift
//  TeskTaskWorkWithNetwork
//
//  Created by Максим Окунеев on 2/22/20.
//  Copyright © 2020 Максим Окунеев. All rights reserved.
//

import Foundation

class UserViewModel: UserViewViewModelType {

    private var selectedIndexPath: IndexPath?
    

    func numberOfRows() -> Int {
        return users.count
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> TableViewCellViewModelType? {
        let user = users[indexPath.row]
        return TableViewCellViewModel(profile: profile)
       }
    
    func viewModelForSelectedRow() -> DetailViewModelType? {
        guard let selectedIndexPath = selectedIndexPath else { return nil }
        return DetailViewModel(profile: profiles[selectedIndexPath.row])
        }
    
    func selectRow(atIndexPath indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
        }
    
}

