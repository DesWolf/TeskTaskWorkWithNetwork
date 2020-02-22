//
//  UserProtocol.swift
//  TeskTaskWorkWithNetwork
//
//  Created by Максим Окунеев on 2/22/20.
//  Copyright © 2020 Максим Окунеев. All rights reserved.
//

import Foundation

protocol UserViewModelType {
    func numberOfRows() -> Int
    func cellViewModel(forIndexPath indexPath: IndexPath) -> TableViewCellViewModelType?
    
    func viewModelForSelectedRow() -> DetailViewModelType?
    func selectRow(atIndexPath indexPath: IndexPath)
}
