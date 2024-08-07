//
//  APIClient.swift
//  swifty-companion
//
//  Created by Anait Kasamanian on 19.06.24.
//

import Foundation
import OAuthSwift


class APIClient {
    static let shared = APIClient()
    
    var oauthswift: OAuth2Swift?
    
    init() {
        oauthswift = OAuth2Handler().oauthswift
        if let token = OAuth2Handler.getToken() {
            oauthswift?.client.credential.oauthToken = token
        }
    }
    
    func fetchMyUserData(completion: @escaping (Result<User, Error>) -> Void) {
        OAuth2Handler().refreshTokenIfNeeded { success in
            guard success, let oauthswift = self.oauthswift else {
                completion(.failure(NSError(domain: "OAuthSwiftError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Token refresh failed"])))
                return
            }
            
            oauthswift.client.get("https://api.intra.42.fr/v2/me") { result in
                switch result {
                case .success(let response):
                    do {
                        let user = try JSONDecoder().decode(User.self, from: response.data)
                        print(user.cursusUsers[1].level)                        // ALTER THE CURSUS THINGY
                        completion(.success(user))
                    } catch let jsonError {
                        print("JSON decoding error: \(jsonError)")
                        completion(.failure(jsonError))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    func fetchUsers(prefix: String, completion: @escaping (Result<[UserPreview], Error>) -> Void) {
           OAuth2Handler().refreshTokenIfNeeded { success in
               guard success, let oauthswift = self.oauthswift else {
                   completion(.failure(NSError(domain: "OAuthSwiftError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Token refresh failed"])))
                   return
               }
               
               let parameters = ["range[login]": "\(prefix.lowercased()),\(prefix.lowercased())z"]
               
               oauthswift.client.get("https://api.intra.42.fr/v2/users", parameters: parameters) { result in
                   switch result {
                   case .success(let response):
                       do {
                           let users = try JSONDecoder().decode([UserPreview].self, from: response.data)
                           completion(.success(users))
                       } catch let jsonError {
                           print("JSON decoding error: \(jsonError)")
                           completion(.failure(jsonError))
                       }
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }
           }
       }
    
    func fetchUserById(userId: Int, completion: @escaping (Result<User,Error>) -> Void ) {
        OAuth2Handler().refreshTokenIfNeeded { success in
            guard success, let oauthswift = self.oauthswift else {
                completion(.failure(NSError(domain: "OAuthSwiftError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Token refresh failed"])))
                return
            }
            
            oauthswift.client.get("https://api.intra.42.fr/v2/users/\(userId)") { result in
                switch result {
                case .success(let response):
                    do {
                        let user = try JSONDecoder().decode(User.self, from: response.data)
                        print(user.login)
                        completion(.success(user))
                    } catch let jsonError {
                        print("JSON decoding error: \(jsonError)")
                        completion(.failure(jsonError))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
                
            }
        }
    }
    
    
}
