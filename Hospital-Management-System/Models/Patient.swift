//
//  Patient.swift
//  Hospital-Management-System
//
//  Created by MACBOOK on 04/06/24.
//

import Foundation
import SwiftUI

// MARK: - EmergencyResponse Model
// Model representing the response for an emergency request
struct EmergencyResponse: Codable {
    let success: Bool
    let emergencyRequest: EmergencyRequest
    
    // Nested struct for the emergency request details
    struct EmergencyRequest: Codable {
        let patient: String
        let status: String
        let description: String
        let _id: String
        let timestamp: String
        let createdAt: String
        let updatedAt: String
        let __v: Int
    }
}

// MARK: - Patient Model
// Model representing a patient
struct Patient: Codable {
    let user: User
    let bloodGroup: String
    let weight: Int
    let height: Int
    let symptom: String
    let address: String
    
    // Custom decoder to decode Patient data
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.user = try container.decode(User.self, forKey: .user)
        self.bloodGroup = try container.decode(String.self, forKey: .bloodGroup)
        self.weight = try container.decode(Int.self, forKey: .weight)
        self.height = try container.decode(Int.self, forKey: .height)
        self.symptom = try container.decode(String.self, forKey: .symptom)
        self.address = try container.decode(String.self, forKey: .address)
    }
}

// MARK: - Category Model
// Model representing a category for doctors
struct Category: Identifiable {
    let id: UUID
    let name: String
    let imageName: String
}

// Predefined categories for doctors
let categories = [
    Category(id: UUID(), name: "Cardiologist", imageName: "heart.fill"),
    Category(id: UUID(), name: "Dermatologist", imageName: "face.smiling.fill"),
    Category(id: UUID(), name: "Neurologist", imageName: "brain.head.profile"),
    Category(id: UUID(), name: "Pediatrician", imageName: "person.3.fill"),
    Category(id: UUID(), name: "Orthopedic Surgeon", imageName: "figure.walk"),
    Category(id: UUID(), name: "Psychiatrist", imageName: "person.crop.circle.badge.exclamationmark"),
    Category(id: UUID(), name: "Ophthalmologist", imageName: "eye.fill"),
    Category(id: UUID(), name: "Radiologist", imageName: "waveform.path.ecg"),
    Category(id: UUID(), name: "General Practitioner", imageName: "stethoscope"),
    Category(id: UUID(), name: "Endocrinologist", imageName: "drop.fill"),
    Category(id: UUID(), name: "Gastroenterologist", imageName: "bandage.fill"),
    Category(id: UUID(), name: "Oncologist", imageName: "cross.fill"),
    Category(id: UUID(), name: "Pulmonologist", imageName: "lungs.fill")
]

// MARK: - PatientForAdmin Model
// Model representing a patient for admin view
struct PatientForAdmin: Codable, Identifiable {
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
    let appointments: [Appointment]?
    let createdAt: String
    let updatedAt: String
    
    // Coding keys to map the JSON keys to struct properties
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
    
    // Custom decoder to decode PatientForAdmin data
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
        self.appointments = try container.decodeIfPresent([Appointment].self, forKey: .appointments)
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
    
    // Computed property to return the ID of the patient
    var id: String {
        return _id
    }
}

// MARK: - DoctorFormView
// SwiftUI view for adding a doctor
struct DoctorFormView: View {
    @State private var name: String = ""
    @State private var selectedCategoryID: UUID? = nil
    
    var body: some View {
        Form {
            // TextField for entering doctor's name
            TextField("Name", text: $name)
            
            // Picker for selecting doctor's category
            Picker("Category", selection: $selectedCategoryID) {
                ForEach(categories) { category in
                    Text(category.name).tag(category.id as UUID?)
                }
            }
            
            // Button to save doctor
            Button(action: {
                // Action to save doctor
            }) {
                Text("Save Doctor")
            }
        }
    }
}

// MARK: - PatientResponse Model
// Model representing the response for fetching patients
struct PatientResponse: Codable {
    let success: Bool
    let data: [User]
}

// Model representing the response for fetching patients for admin view
struct PatientForAdminResponse: Codable {
    let success: Bool
    let data: [PatientForAdmin]
}
