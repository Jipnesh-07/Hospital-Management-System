////
////  Doctor.swift
////  Hospital-Management-System
////
////  Created by MACBOOK on 04/06/24.
////
//
import Foundation

// MARK: DOCTOR

//struct Doctor: Codable {
//    var id: String
//    var user:User
//    var about: String
//    var qualification: String
//    var specialization: String
//    var licenseNumber: String
//    var experience: Int
//
//
//    enum CodingKeys: CodingKey {
//        case id
//        case user
//        case about
//        case qualification
//        case specialization
//        case licenseNumber
//        case experience
//    }
//
//    init(from decoder: any Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.id = try container.decode(String.self, forKey: .id)
//        self.user = try container.decode(User.self, forKey: .user)
//        self.about = try container.decode(String.self, forKey: .about)
//        self.qualification = try container.decode(String.self, forKey: .qualification)
//        self.specialization = try container.decode(String.self, forKey: .specialization)
//        self.licenseNumber = try container.decode(String.self, forKey: .licenseNumber)
//        self.experience = try container.decode(Int.self, forKey: .experience)
//    }
//
//}

import Foundation

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

let sampleScheduleSlot = ScheduleSlot(
    timeSlot: "Morning",
    startTime: "09:00",
    endTime: "11:00"
    
)

struct ScheduleRequest: Codable {
    var schedule: [Schedule]
}



struct Schedule: Codable {
    var date: String
    var slots: [ScheduleSlot]
    
    
    enum CodingKeys: String, CodingKey {
        case date
        case slots
        
    }
}



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
   // var appointments: [DoctorAppointment]?
    let labTestAppointments: [TestDetails]?
    var createdAt: Date
    var updatedAt: Date
    var schedule: [Schedule]?
    
    
    
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
//        case categoryId
        case labTestAppointments
        case fees
        case about
        case specialization
        case experience
        case qualification
       // case appointments
        case createdAt
        case updatedAt
        case schedule
    }
    
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





struct DoctorResponse: Codable {
    var success: Bool
    var data: [Doctor]
}

struct DoctorProfileResponse: Codable {
    var success: Bool
    var data: Doctor
}


//let doctors = [
//    Doctor(id: "#12345", accountType: "doctor", firstName: "Rajiv", lastName: "Kumar", age: 34, gender: "Male", phoneNumber: 1234567890, approved: false, email: "rajiv@doctor.com", password: "123456", categoryId: UUID(), specialization: "Cardiology", experience: "34", qualification: "MBBS", appointments: ["Appointment1","Appointment2"], createdAt: Date(), updatedAt: Date(), schedule: ]
//
//
//let schedules = [
//Schedule(date: Date(), slots: <#T##[ScheduleSlot]#>, id: "#12345")]
//
//
//let Schedule
