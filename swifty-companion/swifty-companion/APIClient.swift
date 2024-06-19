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
    
    func fetchUserData(completion: @escaping (Result<User, Error>) -> Void) {
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
                        completion(.success(user))
                    } catch let jsonError {
                        completion(.failure(jsonError))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}

struct User: Codable {
    let login: String
    let email: String
    let phone: String?
    let level: Double
    let location: String?
    let wallet: Int
    let evaluationPoints: Int
    let imageUrl: String
    let skills: [Skill]
    let projectsUsers: [ProjectUser]
    
    enum CodingKeys: String, CodingKey {
        case login, email, phone, level, location, wallet
        case evaluationPoints = "evaluation_points"
        case imageUrl = "image_url"
        case skills
        case projectsUsers = "projects_users"
    }
}

struct Skill: Codable {
    let name: String
    let level: Double
}

struct ProjectUser: Codable {
    let project: Project
    let status: String
}

struct Project: Codable {
    let name: String
}
