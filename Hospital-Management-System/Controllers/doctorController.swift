//
//  doctorController.swift
//  Hospital-Management-System
//
//  Created by Ravneet Singh on 12/06/24.
//

import Foundation

// DoctorService class manages doctor-related operations and API calls
class DoctorService: ObservableObject {
    // Authentication token retrieved from UserDefaults
    let token: String = UserDefaults.standard.string(forKey: "authToken") ?? ""
    
    // Base URL for doctor-related API endpoints
    let baseURL = "https://hms-backend-1-1aof.onrender.com/doctor"
    
    // Published properties to trigger UI updates
    @Published var showSuccessAlert = false
    @Published var doctor: Doctor?
    @Published var appointments: [DoctorAppointment] = []
    
    // Function to fetch doctor appointments
    func getAppointments() {
        let urlString = "\(baseURL)/appointments"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        print("Printing saved token: \(token)")
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(String(describing: token))", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error fetching appointments: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                decoder.dateDecodingStrategy = .formatted(dateFormatter)
                
                let appointmentResponse = try decoder.decode(DoctorAppointmentResponse.self, from: data)
                DispatchQueue.main.async {
                    self.appointments = appointmentResponse.data
                    
                    if let dataString = String(data: data, encoding: .utf8) {
                        print("Raw JSON response: \(dataString)")
                    }
                }
            } catch {
                print("Data mapping error")
                print("Error decoding appointments: \(error.localizedDescription)")
                if let dataString = String(data: data, encoding: .utf8) {
                    print("Raw JSON response: \(dataString)")
                }
            }
        }
        
        task.resume()
    }
    
    // Function to add a schedule for a doctor
    func addSchedule(schedule: Schedule, completion: @escaping (Bool) -> Void) {
        print("Entered add schedule")
        let url = URL(string: "\(baseURL)/addSchedule")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        
        let scheduleRequest = ScheduleRequest(schedule: [schedule])
        
        print(scheduleRequest)
        
        if let encodedSchedule = try? encoder.encode(scheduleRequest) {
            request.httpBody = encodedSchedule
        } else {
            print("Failed to encode schedule")
            completion(false)
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error adding schedule: \(error.localizedDescription)")
                completion(false)
                return
            }
            
            guard let data = data else {
                print("No data received")
                completion(false)
                return
            }
            
            if let responseString = String(data: data, encoding: .utf8) {
                print("Response: \(responseString)")
                completion(true)
            } else {
                completion(false)
            }
        }.resume()
    }
    
    // Function to fetch doctor profile data
    func fetchDoctorData(completion: @escaping (Bool) -> Void) {
        let urlString = "\(baseURL)/getprofile"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            completion(false)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error fetching doctor data: \(error.localizedDescription)")
                completion(false)
                return
            }
            
            guard let data = data else {
                print("No data received")
                completion(false)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                decoder.dateDecodingStrategy = .formatted(dateFormatter)
                
                let doctorResponse = try decoder.decode(DoctorProfileResponse.self, from: data)
                DispatchQueue.main.async {
                    self.doctor = doctorResponse.data
                    completion(true)
                }
            } catch {
                print("Error decoding doctor data: \(error.localizedDescription)")
                completion(false)
            }
        }
        
        task.resume()
    }
    
    // Function to add a prescription for an appointment
    func addPrescription(appointmentId: String, prescription: String, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "\(baseURL)/prescription/\(appointmentId)") else {
            print("Invalid URL")
            completion(false)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let body: [String: Any] = [
            "prescription": prescription
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        } catch {
            print("Failed to serialize JSON: \(error.localizedDescription)")
            completion(false)
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error adding prescription: \(error.localizedDescription)")
                completion(false)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response")
                completion(false)
                return
            }
            
            if httpResponse.statusCode == 200 {
                print("Prescription added successfully")
                completion(true)
            } else {
                print("Failed with status code: \(httpResponse.statusCode)")
                completion(false)
            }
        }
        
        task.resume()
    }
    
    // Function to add a test for an appointment
    func addTest(appointmentId: String, test: String, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "\(baseURL)/tests/\(appointmentId)") else {
            print("Invalid URL")
            completion(false)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let body: [String: Any] = [
            "tests": ["testName": test]
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        } catch {
            print("Failed to serialize JSON: \(error.localizedDescription)")
            completion(false)
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error adding test: \(error.localizedDescription)")
                completion(false)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response")
                completion(false)
                return
            }
            
            if httpResponse.statusCode == 200 {
                print("Test added successfully")
                completion(true)
            } else {
                print("Failed with status code: \(httpResponse.statusCode)")
                completion(false)
            }
        }
        
        task.resume()
    }
}

// DoctorAPI class manages admin-related doctor operations and API calls
class DoctorAPI {
    static let shared = DoctorAPI()
    
    let token: String = UserDefaults.standard.string(forKey: "authToken") ?? ""
    private let baseURL = "https://hms-backend-1-1aof.onrender.com/admin"
    
    // Function to get the list of doctors
    func getDoctors(completion: @escaping (Result<DoctorResponse, Error>) -> Void) {
        let urlString = "\(baseURL)/doctors"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImFkbWluQGhvc3BpdGFsLmNvbSIsImlkIjoiNjY2YjRiNmIyZjE3ZDJjNWY2MDBiODg3IiwiaWF0IjoxNzE4MzExNDQxfQ.adgihm2l5fUYNwm9brhkbyrPjxe0LKmze32sI8mMZiY", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid response"])))
                return
            }
            
            print("Status Code: \(httpResponse.statusCode)")
            
            if !(200...299).contains(httpResponse.statusCode) {
                if let data = data, let responseBody = String(data: data, encoding: .utf8) {
                    print("Response Body: \(responseBody)")
                }
                completion(.failure(NSError(domain: "", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: "Server error"])))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                decoder.dateDecodingStrategy = .formatted(dateFormatter)
                
                let doctorResponse = try decoder.decode(DoctorResponse.self, from: data)
                completion(.success(doctorResponse))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    // Function to approve a doctor
    func approveDoctor(doctorID: String, completion: @escaping (Result<Doctor, Error>) -> Void) {
        let urlString = "\(baseURL)/doctors/\(doctorID)/approve"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid response"])))
                return
            }
            
            if !(200...299).contains(httpResponse.statusCode) {
                completion(.failure(NSError(domain: "", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: "Server error"])))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                decoder.dateDecodingStrategy = .formatted(dateFormatter)
                
                let doctor = try decoder.decode(Doctor.self, from: data)
                completion(.success(doctor))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    // Function to reject a doctor
    func rejectDoctor(doctorID: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        let urlString = "\(baseURL)/doctors/\(doctorID)"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid response"])))
                return
            }
            
            if !(200...299).contains(httpResponse.statusCode) {
                completion(.failure(NSError(domain: "", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: "Server error"])))
                return
            }
            
            completion(.success(true))
        }
        
        task.resume()
    }
}
