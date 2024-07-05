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
                        print(user.cursusUsers[1].level)
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

// MARK: - User
struct User: Codable {
    let email, login, displayname, kind: String
    let image: UserImage
    let phone: String?
    let correctionPoint: Int
    let location: String?
    let wallet: Int
    let cursusUsers: [CursusUser]
    let projectsUsers: [ProjectsUser]
    let campus: [Campus]

    enum CodingKeys: String, CodingKey {
        case email, login, displayname, kind, image
        case correctionPoint = "correction_point"
        case location, wallet
        case cursusUsers = "cursus_users"
        case projectsUsers = "projects_users"
        case campus
        case phone
    }
}



// MARK: - CursusUser
struct CursusUser: Codable {
    let level: Double
    let skills: [Skill]
    let blackholedAt: String?
    let id: Int
    let beginAt: String
    let endAt: String?
    let cursusID: Int
    let hasCoalition: Bool
    let createdAt, updatedAt: String
    let cursus: Cursus

    enum CodingKeys: String, CodingKey {
        case level, skills
        case blackholedAt = "blackholed_at"
        case id
        case beginAt = "begin_at"
        case endAt = "end_at"
        case cursusID = "cursus_id"
        case hasCoalition = "has_coalition"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case cursus
    }
}

// MARK: - Cursus
struct Cursus: Codable {
    let id: Int
    let createdAt, name, slug, kind: String

    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case name, slug, kind
    }
}

// MARK: - Skill
struct Skill: Codable {
    let id: Int
    let name: String
    let level: Double
}


// MARK: - UserImage
struct UserImage: Codable {
    let link: String?
    let versions: PurpleVersions
}

// MARK: - PurpleVersions
struct PurpleVersions: Codable {
    let large, medium, small, micro: String?
}



// MARK: - ProjectsUser
struct ProjectsUser: Codable, Identifiable {
    let id, occurrence: Int
    let finalMark: Int?
    let status: Status?
    let validated: Bool?
    let project: Project
    let markedAt: String?
    let marked: Bool
    let retriableAt: String?
    let updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, occurrence
        case finalMark = "final_mark"
        case status
        case validated = "validated?"
        case project
        case markedAt = "marked_at"
        case marked
        case retriableAt = "retriable_at"
        case updatedAt = "updated_at"
    }
}

// MARK: - FluffyVersions
struct FluffyVersions: Codable {
    let large, small: URL?
}


// MARK: - Project
struct Project: Codable {
    let name: String

    enum CodingKeys: String, CodingKey {
        case name
    }
}

enum Status: String, Codable {
    case finished = "finished"
    case inProgress = "in_progress"
    case parent = "parent"
    case searchingAGroup = "searching_a_group"
    case waitingForCorrection = "waiting_for_correction"
    case creatingGroup = "creating_group"
}

// MARK: - Campus
struct Campus: Codable {
    let id: Int
    let name: String

    
    enum CodingKeys: String, CodingKey {
        case id, name
    }
}
