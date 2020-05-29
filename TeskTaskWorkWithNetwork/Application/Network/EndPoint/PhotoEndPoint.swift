//
//  PhotoEndPoint.swift
//  TeskTaskWorkWithNetwork
//
//  Created by Максим Окунеев on 5/13/20.
//  Copyright © 2020 Максим Окунеев. All rights reserved.
//

import Foundation

public enum ImageApi {
    case photoImage(imageUrl: String)
}

extension ImageApi: EndPointType {
    
    var environmentBaseURL : String {
        switch NetworkManagerImageData.environment {
        case .qa: return "https://via.placeholder.com/"
        case .production: return "https://via.placeholder.com/"
        case .staging: return "https://via.placeholder.com/"
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .photoImage(let imageUrl):
            return "\(imageUrl)"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        return .request
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
