//
//  Models.swift
//  swifty-companion
//
//  Created by Anait Kasamanian on 13.07.24.
//

import Foundation

// MARK: - User
struct User: Codable, Identifiable {
    let id: Int
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
        case id, email, login, displayname, kind, image, phone
        case correctionPoint = "correction_point"
        case location, wallet
        case cursusUsers = "cursus_users"
        case projectsUsers = "projects_users"
        case campus
    }
}

// MARK: - CursusUser
struct CursusUser: Codable, Identifiable {
    let id: Int
    let level: Double
    let skills: [Skill]
    let blackholedAt: String?
    let beginAt: String
    let endAt: String?
    let cursusID: Int
    let hasCoalition: Bool
    let createdAt, updatedAt: String
    let cursus: Cursus

    enum CodingKeys: String, CodingKey {
        case id, level, skills
        case blackholedAt = "blackholed_at"
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
struct Cursus: Codable, Identifiable {
    let id: Int
    let createdAt, name, slug, kind: String

    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case name, slug, kind
    }
}

// MARK: - Skill
struct Skill: Codable, Identifiable {
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

// MARK: - Project
struct Project: Codable, Identifiable {
    let id: Int
    let name: String
    let status: Status?
    let finalMark: Int?

    enum CodingKeys: String, CodingKey {
        case id, name, status
        case finalMark = "final_mark"
    }
}

// MARK: - Status Enum
enum Status: String, Codable {
    case finished = "finished"
    case inProgress = "in_progress"
    case parent = "parent"
    case searchingAGroup = "searching_a_group"
    case waitingForCorrection = "waiting_for_correction"
    case creatingGroup = "creating_group"
}

// MARK: - Campus
struct Campus: Codable, Identifiable {
    let id: Int
    let name: String

    enum CodingKeys: String, CodingKey {
        case id, name
    }
}
