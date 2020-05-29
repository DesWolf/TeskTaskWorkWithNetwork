//
//  HTTPMethod.swift
//  TeskTaskWorkWithNetwork
//
//  Created by Максим Окунеев on 5/7/20.
//  Copyright © 2020 Максим Окунеев. All rights reserved.
//

import Foundation

public enum HTTPMethod : String {
    case get     = "GET"
    case post    = "POST"

  // Review: Взято из Moya, но кейсы ниже не нужны
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
}
