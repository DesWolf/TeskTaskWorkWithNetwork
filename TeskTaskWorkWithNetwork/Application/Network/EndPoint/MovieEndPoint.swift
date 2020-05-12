//
//  MovieEndopointType.swift
//  TeskTaskWorkWithNetwork
//
//  Created by Максим Окунеев on 5/7/20.
//  Copyright © 2020 Максим Окунеев. All rights reserved.
//

import Foundation

enum NetworkEnvironment {
    //    case qa
    case mainData
    case imageData
    //    case staging
}

public enum MovieApi {
    //    case recommended(id:Int)
    //    case popular(page:Int)
    //    case newMovies(page:Int)
    //    case video(id:Int)
    case users
    case albums
    case photos(albumId: Int)
    case photoImage
}

extension MovieApi: EndPointType {
    
    var environmentBaseURL : String {
        switch NetworkManagerMainData.environment {
        case .mainData: return "https://jsonplaceholder.typicode.com/"
        case .imageData: return ""
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
        case .photoImage:
            return ""
            //        case .recommended(let id):
            //            return "\(id)/recommendations"
            //        case .popular:
            //            return "popular"
            //        case .newMovies:
            //            return "now_playing"
            //        case .video(let id):
            //            return "\(id)/videos"
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
            //        case .newMovies(let page):
            //            return .requestParameters(bodyParameters: nil,
            //                                      bodyEncoding: .urlEncoding,
            //                                      urlParameters: ["page":page,
        //                                                      "api_key":NetworkManager.MovieAPIKey])
        default:
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
