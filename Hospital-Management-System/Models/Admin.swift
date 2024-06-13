//
//  Admin.swift
//  Hospital-Management-System
//
//  Created by MACBOOK on 04/06/24.
//

import Foundation

struct Admin: Decodable{
    let user: User
    
    init(user: User) {
        self.user = user
    }
    
    enum CodingKeys: CodingKey {
        case user
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.user = try container.decode(User.self, forKey: .user)
    }
    
    
}

import Foundation

struct EmergencyAdminRequest: Codable, Identifiable {
    let _id: String
    let patient: Patient2
    let status: String
    let description: String
    let timestamp: String
    
    var id: String { _id }
}

struct Patient2: Codable {
    let _id: String
    let firstName: String
    let lastName: String
    let age: Int
    let gender: String
    let phoneNumber: Int
    let email: String
    let bloodGroup: String
}


struct EmergencyAdminResponse: Codable {
    let success: Bool
    let emergencyRequests: [EmergencyAdminRequest]
}
