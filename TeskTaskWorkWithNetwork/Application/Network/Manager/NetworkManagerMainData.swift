//
//  NetworkManager.swift
//  TeskTaskWorkWithNetwork
//
//  Created by Максим Окунеев on 5/7/20.
//  Copyright © 2020 Максим Окунеев. All rights reserved.
//

import UIKit

// Review: Хорошо бы использовать swiftlint. Много неаккуратности, неконсистентности в определении классов, пробелов и т.п.
enum NetworkResponse:String {
    case success
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
}

// Review: Можно использовать родной Result<>, а ошибки схлопывать до одной строки - плохой способ.
// Хорошо бы реализовывать протокол Error, а внутри отдавать localizedDescription (тоже часть протокола).
// Такие ошибки затем легко обрабатывать на слое представления. Например, класть внутрь alert error.localizedDescription
enum Result<String>{
    case success
    case failure(String)
}


struct NetworkManagerMainData {
    static let environment : NetworkEnvironment = .production
    private let router = Router<DataApi>()
    
    func fetchUsersData(completion: @escaping (_ users: [User]?,_ error: String?)->()){
        router.request(.users) { data, response, error in

            // Review: Код обработки одинаковый. Стоило бы сделать методы, и не повторяться.
            // Помогут Generic методы.
            // Error и опциональный response можно было передавать в handleNetworkResponse
            // сompletion реализован 5 раз, это можно оптимизировать, и сделать централизованным.

            if error != nil {
                completion(nil, "Please check your network connection.")
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        let apiResponse = try JSONDecoder().decode([User].self, from: responseData)
                        completion(apiResponse,nil)
                    }catch {
                        print(error)
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        }
    }
    
    func fetchAlbumData(completion: @escaping (_ albums: [Album]?,_ error: String?)->()){
        router.request(.albums) { data, response, error in
            
            if error != nil {
                completion(nil, "Please check your network connection.")
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        let apiResponse = try JSONDecoder().decode([Album].self, from: responseData)
                        completion(apiResponse,nil)
                    }catch {
                        print(error)
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        }
    }
    func fetchPhotosData(albumId: Int, completion: @escaping (_ photo: [PhotoInfo]?,_ error: String?)->()){
        router.request(.photos(albumId: albumId)) { data, response, error in
            
            if error != nil {
                completion(nil, "Please check your network connection.")
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        let apiResponse = try JSONDecoder().decode([PhotoInfo].self, from: responseData)
                        completion(apiResponse,nil)
                    }catch {
                        print(error)
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
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
