//
//  MovieEndopointType.swift
//  TeskTaskWorkWithNetwork
//
//  Created by Максим Окунеев on 5/7/20.
//  Copyright © 2020 Максим Окунеев. All rights reserved.
//

import Foundation

enum NetworkEnvironment {
    case qa
    case production
    case staging
}

public enum DataApi {
    case users
    case albums
    case photos(albumId: Int)
    case photoImage(imageUrl: String) // Review: Не используется
}

extension DataApi: EndPointType {
    
    var environmentBaseURL : String {
        // Review: Одинаковое значение, switch не нужен.
        switch NetworkManagerMainData.environment {
        case .qa: return "https://jsonplaceholder.typicode.com/"
        case .production: return "https://jsonplaceholder.typicode.com/"
        case .staging: return "https://jsonplaceholder.typicode.com/"
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .users:
            return "users"
        case .albums:
            return "albums"
        case .photos(_):
            return "photos"
        case .photoImage(let imageUrl):
            return "\(imageUrl)"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .photos(let albumId):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: ["albumId": albumId])
        default:
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
