//
//  albumsModel.swift
//  TeskTaskWorkWithNetwork
//
//  Created by Максим Окунеев on 2/19/20.
//  Copyright © 2020 Максим Окунеев. All rights reserved.
//

import Foundation

struct Album: Decodable {
    
    let userId: Int?
    let id: Int?
    let title: String?
}

