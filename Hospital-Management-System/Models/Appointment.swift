//
//  Appointment.swift
//  Hospital-Management-System
//
//  Created by MACBOOK on 05/06/24.
//


import Foundation
import Combine

struct PatientAppointmentData: Codable {
    var _id: String
    var firstName: String
    var lastName: String
    var age: Int
    var gender: String
    
    enum CodingKeys: String, CodingKey {
        case _id = "_id"
        case firstName
        case lastName
        case age
        case gender
    }
}

struct DoctorAppointmentData: Codable {
    var id: String
    var firstName: String
    var lastName: String
    var specialization: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case firstName
        case lastName
        case specialization
    }
}




struct PatientAppointment: Codable, Identifiable {
    enum TimeSlot: String, Codable {
        case morning = "Morning"
        case afternoon = "Afternoon"
        case evening = "Evening"
    }
    
    var id: String
    var patient: String
    var doctor: DoctorAppointmentData
    var date: Date
    var timeSlot: TimeSlot
    var symptom: String
    var status: String
    var prescription: String?
    var tests: [String]
    var createdAt: Date
    var updatedAt: Date
    
    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case patient
        case doctor
        case date
        case timeSlot
        case symptom
        case status
        case prescription
        case tests
        case createdAt
        case updatedAt
    }
}


struct DoctorAppointment: Codable, Identifiable {
    enum TimeSlot: String, Codable {
        case morning = "Morning"
        case afternoon = "Afternoon"
        case evening = "Evening"
    }
    
    struct Test: Codable {
        
        var testName: String
        var result: String
        
        
        private enum CodingKeys: String, CodingKey {
            case testName
            case result
        }
        
    }
    
    var id: String
    var patient: PatientAppointmentData
    var symptom: String?
    var doctor: String
    var date: Date
    var timeSlot: TimeSlot
    var status: String
    var prescription: String
    var tests: [Test]?
    var createdAt: Date
    var updatedAt: Date
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case patient
        case symptom
        case doctor
        case date
        case timeSlot
        case status
        case tests
        case prescription
        case createdAt
        case updatedAt
    }
}

//let patientAppointmentsSample = [
//    PatientAppointment(_id: "#12345", patient: "Rajiv", doctor: DoctorAppointmentData(_id: "#123456", firstName: "Rajiv", lastName: "Kumar", specialization: "Cardiology"), date: Date(), timeSlot:PatientAppointment.TimeSlot.morning, createdAt: Date(), updatedAt: Date())]

struct PatientAppointmentResponse: Codable {
    let success: Bool
    let data: [PatientAppointment]
}

struct DoctorAppointmentResponse: Codable {
    var success: Bool
    var data: [DoctorAppointment]
}


//import Foundation

//func fetchPatientAppointments(token: String) {
//    print("Entered Fetch function")
//    let urlString = "http://localhost:4000/patient/appointments"
//    guard let url = URL(string: urlString) else { return }
//    
//    var request = URLRequest(url: url)
//    request.httpMethod = "GET"
//    request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
//    
//    print("Entered 2")
//    let task = URLSession.shared.dataTask(with: request) { data, response, error in
//        if let error = error {
//            print("Error: \(error)")
//            return
//        }
//        
//        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
//            print("Server error")
//            return
//        }
//        
//        guard let data = data else {
//            print("No data received")
//            return
//        }
//        
//        do {
//            let decoder = JSONDecoder()
//            
//            // Custom Date Decoding Strategy
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
//            decoder.dateDecodingStrategy = .formatted(dateFormatter)
//            
//            let appointmentResponse = try decoder.decode(PatientAppointmentResponse.self, from: data)
//            print("Success: \(appointmentResponse.success)")
//            for appointment in appointmentResponse.data {
//                print("Appointment ID: \(appointment._id), Patient ID: \(appointment.patient), Doctor: \(appointment.doctor.firstName) \(appointment.doctor.lastName), Date: \(appointment.date), Time Slot: \(appointment.timeSlot.rawValue)")
//            }
//        } catch {
//            print("Error decoding JSON: \(error)")
//        }
//    }
//    
//    task.resume()
//}



func fetchDoctorAppointments(token: String) {
    print("Entered Fetch function")
    let urlString = "http://localhost:4000/doctor/appointments"
    guard let url = URL(string: urlString) else { return }
    
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    
    print("Entered 2")
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            print("Error: \(error)")
            return
        }
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            print("Server error")
            return
        }
        
        guard let data = data else {
            print("No data received")
            return
        }
        
        do {
            let decoder = JSONDecoder()
            
            // Custom Date Decoding Strategy
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            decoder.dateDecodingStrategy = .formatted(dateFormatter)
            
            let appointmentResponse = try decoder.decode(DoctorAppointmentResponse.self, from: data)
            print("Success: \(appointmentResponse.success)")
            for appointment in appointmentResponse.data {
                print("Appointment ID: \(appointment.id), Patient: \(appointment.patient.firstName) \(appointment.patient.lastName), Doctor ID: \(appointment.doctor), Date: \(appointment.date), Time Slot: \(appointment.timeSlot.rawValue)")
                if let symptom = appointment.symptom {
                    print("Symptom: \(symptom)")
                }
            }
        } catch {
            print("Error decoding JSON: \(error)")
        }
    }
    
    task.resume()
}



