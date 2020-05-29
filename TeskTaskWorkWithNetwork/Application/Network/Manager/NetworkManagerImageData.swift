//
//  NetworkManagerImageData.swift
//  TeskTaskWorkWithNetwork
//
//  Created by Максим Окунеев on 5/12/20.
//  Copyright © 2020 Максим Окунеев. All rights reserved.
//

import UIKit

struct NetworkManagerImageData {
    static let environment : NetworkEnvironment = .production
    private let router = Router<ImageApi>()
    
    func fetchImage(imageUrl: String, completion: @escaping (UIImage?,_ error: String?)->()){
        router.request(.photoImage(imageUrl: imageUrl)) { data, response, error in
            
            if error != nil {
                completion(nil, "Please check your network connection.")
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let image = UIImage(data: data!) else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    completion(image,nil)
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        }
    }
    
    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String>{
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
}
