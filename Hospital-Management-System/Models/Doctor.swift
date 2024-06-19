//
//  Doctor.swift
//  Hospital-Management-System
//
//  Created by MACBOOK on 04/06/24.
//

import Foundation

// MARK: - ScheduleSlot Model
// Model representing a time slot in a schedule
struct ScheduleSlot: Codable {
    var timeSlot: String
    var startTime: String
    var endTime: String
    
    enum CodingKeys: String, CodingKey {
        case timeSlot
        case startTime
        case endTime
    }
}

// Sample data for ScheduleSlot
let sampleScheduleSlot = ScheduleSlot(
    timeSlot: "Morning",
    startTime: "09:00",
    endTime: "11:00"
)

// MARK: - ScheduleRequest Model
// Model representing a request to set a schedule
struct ScheduleRequest: Codable {
    var schedule: [Schedule]
}

// MARK: - Schedule Model
// Model representing a schedule for a doctor
struct Schedule: Codable {
    var date: String
    var slots: [ScheduleSlot]
    
    enum CodingKeys: String, CodingKey {
        case date
        case slots
    }
}

// MARK: - Doctor Model
// Model representing a doctor
struct Doctor: Identifiable, Codable {
    var id: String
    var accountType: String
    var firstName: String
    var lastName: String
    var age: Int
    var gender: String
    var phoneNumber: Int
    var approved: Bool
    var email: String
    var password: String
    var fees: String
    var about: String
    var specialization: String
    var experience: String
    var qualification: String
    let labTestAppointments: [TestDetails]?
    var createdAt: Date
    var updatedAt: Date
    var schedule: [Schedule]?
    
    // Coding keys to map the JSON keys to struct properties
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case accountType
        case firstName
        case lastName
        case age
        case gender
        case phoneNumber
        case approved
        case email
        case password
        case labTestAppointments
        case fees
        case about
        case specialization
        case experience
        case qualification
        case createdAt
        case updatedAt
        case schedule
    }
    
    // Custom decoder to decode Doctor data
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.accountType = try container.decode(String.self, forKey: .accountType)
        self.firstName = try container.decode(String.self, forKey: .firstName)
        self.lastName = try container.decode(String.self, forKey: .lastName)
        self.age = try container.decode(Int.self, forKey: .age)
        self.gender = try container.decode(String.self, forKey: .gender)
        self.phoneNumber = try container.decode(Int.self, forKey: .phoneNumber)
        self.approved = try container.decode(Bool.self, forKey: .approved)
        self.email = try container.decode(String.self, forKey: .email)
        self.password = try container.decode(String.self, forKey: .password)
        self.labTestAppointments = try container.decodeIfPresent([TestDetails].self, forKey: .labTestAppointments)
        self.fees = try container.decode(String.self, forKey: .fees)
        self.about = try container.decode(String.self, forKey: .about)
        self.specialization = try container.decode(String.self, forKey: .specialization)
        self.experience = try container.decode(String.self, forKey: .experience)
        self.qualification = try container.decode(String.self, forKey: .qualification)
        self.createdAt = try container.decode(Date.self, forKey: .createdAt)
        self.updatedAt = try container.decode(Date.self, forKey: .updatedAt)
        self.schedule = try container.decodeIfPresent([Schedule].self, forKey: .schedule)
    }
}

// MARK: - DoctorResponse Model
// Model representing the response for fetching doctors
struct DoctorResponse: Codable {
    var success: Bool
    var data: [Doctor]
}

// MARK: - DoctorProfileResponse Model
// Model representing the response for fetching a single doctor's profile
struct DoctorProfileResponse: Codable {
    var success: Bool
    var data: Doctor
}
