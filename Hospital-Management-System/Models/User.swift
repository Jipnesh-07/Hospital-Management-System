
import Foundation
import SwiftUI
// MARK: USER
struct User: Codable, Identifiable {
    let _id: String
    let accountType: String
    let firstName: String
    let lastName: String
    let age: Int
    let gender: String
    let bloodGroup: String?
    let height: Int?
    let weight: Int?
    let phoneNumber: Int
    let approved: Bool
    let email: String
    let password: String
    let licenseNumber: String?
    let specialization: String?
    let schedule: [Schedule]?
    let experience: String?
    let appointments: [String]?
    let createdAt: String
    let updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case _id
        case accountType
        case firstName
        case lastName
        case age
        case gender
        case phoneNumber
        case approved
        case email
        case password
        case bloodGroup
        case weight
        case height
        case appointments
        case licenseNumber
        case experience
        case specialization
        case schedule
        case createdAt
        case updatedAt
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self._id = try container.decode(String.self, forKey: ._id)
        self.accountType = try container.decode(String.self, forKey: .accountType)
        self.firstName = try container.decode(String.self, forKey: .firstName)
        self.lastName = try container.decode(String.self, forKey: .lastName)
        self.age = try container.decode(Int.self, forKey: .age)
        self.gender = try container.decode(String.self, forKey: .gender)
        self.phoneNumber = try container.decode(Int.self, forKey: .phoneNumber)
        self.approved = try container.decode(Bool.self, forKey: .approved)
        self.email = try container.decode(String.self, forKey: .email)
        self.password = try container.decode(String.self, forKey: .password)
        self.appointments = try container.decodeIfPresent([String].self, forKey: .appointments)
        self.schedule = try container.decodeIfPresent([Schedule].self, forKey: .schedule)
        self.createdAt = try container.decode(String.self, forKey: .createdAt)
        self.updatedAt = try container.decode(String.self, forKey: .updatedAt)
        self.bloodGroup = try container.decodeIfPresent(String.self, forKey: .bloodGroup)
        self.height = try container.decodeIfPresent(Int.self, forKey: .height)
        self.weight = try container.decodeIfPresent(Int.self, forKey: .weight)
        self.licenseNumber = try container.decodeIfPresent(String.self, forKey: .licenseNumber)
        self.specialization = try container.decodeIfPresent(String.self, forKey: .specialization)
        self.experience = try container.decodeIfPresent(String.self, forKey: .experience)
    }
    
    var id: String {
        return _id
    }
}

struct UserRegistrationResponse: Decodable {
//    let message: String
    let user: User
    let token: String
    //    let type: String
    
    enum CodingKeys: CodingKey {
        case message
        case user
        case token
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.message = try container.decode(String.self, forKey: .message)
        self.user = try container.decode(User.self, forKey: .user)
        self.token = try container.decode(String.self, forKey: .token)
    }
}

struct SigninResponse: Codable {
    var user: User
    var token: String
    let accountType: String
}

struct DoctorSigninResponse: Codable {
    var user: Doctor
    var token: String
    let accountType: String
}


