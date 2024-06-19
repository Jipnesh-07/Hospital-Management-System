//
//  Admin.swift
//  Hospital-Management-System
//
//  Created by MACBOOK on 04/06/24.
//

import Foundation

// MARK: - Admin Model
// Model representing an Admin, which contains a user property
struct Admin: Decodable {
    let user: User
    
    // Initializer for the Admin struct
    init(user: User) {
        self.user = user
    }
    
    // Coding keys to map the JSON keys to struct properties
    enum CodingKeys: CodingKey {
        case user
    }
    
    // Custom decoder to decode Admin data
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.user = try container.decode(User.self, forKey: .user)
    }
}

// MARK: - EmergencyAdminRequest Model
// Model representing an emergency request for admin view
struct EmergencyAdminRequest: Codable, Identifiable {
    let _id: String
    let patient: Patient2
    let status: String
    let description: String
    let timestamp: String
    
    // Computed property to conform to Identifiable protocol
    var id: String { _id }
}

// MARK: - Patient2 Model
// Model representing a patient
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

// MARK: - EmergencyAdminResponse Model
// Model representing the response for emergency requests for admin view
struct EmergencyAdminResponse: Codable {
    let success: Bool
    let emergencyRequests: [EmergencyAdminRequest]
}
