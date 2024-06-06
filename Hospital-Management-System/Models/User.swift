//
//  User.swift
//  Hospital-Management-System
//
//  Created by MACBOOK on 05/06/24.
//

import Foundation
import SwiftUI
// MARK: USER

struct User: Codable{
    let _id: String
    let accountType: String
    let firstName: String
    let lastName: String
    let age: Int
    let gender: String
    let phoneNumber: Int
    let approved: Bool
    let email: String
    let password: String
    let appointments: [String]
    let schedule: [String]
    let createdAt: String
    let updatedAt: String
    
//    init(_id: String, accountType: String, firstName: String, lastName: String, age: Int, gender: String, phoneNumber: Int, approved: Bool, email: String, password: String, appointments: [String], schedule: [String], createdAt: String, updatedAt: String) {
//        self._id = _id
//        self.accountType = accountType
//        self.firstName = firstName
//        self.lastName = lastName
//        self.age = age
//        self.gender = gender
//        self.phoneNumber = phoneNumber
//        self.approved = approved
//        self.email = email
//        self.password = password
//        self.appointments = appointments
//        self.schedule = schedule
//        self.createdAt = createdAt
//        self.updatedAt = updatedAt
//    }
    
    enum CodingKeys: CodingKey {
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
        case appointments
        case schedule
        case createdAt
        case updatedAt
    }
    
    init(from decoder: any Decoder) throws {
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
        self.appointments = try container.decode([String].self, forKey: .appointments)
        self.schedule = try container.decode([String].self, forKey: .schedule)
        self.createdAt = try container.decode(String.self, forKey: .createdAt)
        self.updatedAt = try container.decode(String.self, forKey: .updatedAt)
    }
}


struct UserRegistrationResponse: Decodable {
    let message: String
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
        self.message = try container.decode(String.self, forKey: .message)
        self.user = try container.decode(User.self, forKey: .user)
        self.token = try container.decode(String.self, forKey: .token)
    }
}

struct SigninResponse: Codable {
    var user: User
    var token: String
}

