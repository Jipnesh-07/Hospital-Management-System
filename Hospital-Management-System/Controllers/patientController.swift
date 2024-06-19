//
//  patientController.swift
//  Hospital-Management-System
//
//  Created by MACBOOK on 05/06/24.
//

import Foundation
import Combine

// Service class responsible for patient-related operations
class PatientService: ObservableObject {
    
    // Fetches authentication token from UserDefaults
    let token: String = UserDefaults.standard.string(forKey: "authToken") ?? ""
    
    // Base URL for patient-related API endpoints
    let baseURL = "https://hms-backend-1-1aof.onrender.com/patient"
    
    // Published property to observe appointment results
    @Published var appointmentResult: Result<TestDetails, Error>? = nil
    
    // Published array of patient appointments
    @Published var appointments: [PatientAppointment] = []
    
    // Published array of lab appointments
    @Published var labAppointments: [TestDetails] = []
    
    // Function to search for doctors based on a query
    func searchDoctors(query: String, completion: @escaping (Result<DoctorResponse, Error>) -> Void) {
        let urlString = "\(baseURL)/doctors/search/\(query)"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
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
                // Print response data for debugging
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
                // Custom Date Decoding Strategy
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
    
    // Function to fetch all doctors
    func getDoctors(completion: @escaping (Result<DoctorResponse, Error>) -> Void) {
        let urlString = "\(baseURL)/doctors"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
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
                // Print response data for debugging
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
                // Custom Date Decoding Strategy
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
    
    // Function to book a doctor appointment
    func bookDocAppointment(docId: String, timeSlot: String, date: String, symptom: String) {
        guard let url = URL(string: "\(baseURL)/bookappointment") else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let parameters: [String: Any] = [
            "doctorId": docId,
            "timeSlot": timeSlot,
            "date": date,
            "symptom": symptom
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
        } catch {
            appointmentResult = .failure(error)
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.appointmentResult = .failure(error)
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    self.appointmentResult = .failure(NSError(domain: "No Data", code: -1, userInfo: nil))
                }
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let response = try decoder.decode(BookAppointmentResponse.self, from: data)
                DispatchQueue.main.async {
                    self.appointmentResult = .success(response.data)
                }
            } catch {
                DispatchQueue.main.async {
                    self.appointmentResult = .failure(error)
                }
            }
        }.resume()
    }
    
    // Function to book a lab test appointment
    func bookLabAppointment(testName: String, timeSlot: String, date: String) {
        guard let url = URL(string: "\(baseURL)/booktest") else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let parameters: [String: Any] = [
            "testName": testName,
            "timeSlot": timeSlot,
            "date": date
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
        } catch {
            appointmentResult = .failure(error)
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.appointmentResult = .failure(error)
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    self.appointmentResult = .failure(NSError(domain: "No Data", code: -1, userInfo: nil))
                }
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let response = try decoder.decode(BookAppointmentResponse.self, from: data)
                DispatchQueue.main.async {
                    self.appointmentResult = .success(response.data)
                }
            } catch {
                DispatchQueue.main.async {
                    self.appointmentResult = .failure(error)
                }
            }
        }.resume()
    }
    
    // Function to fetch patient appointments
    func getAppointments() {
        let urlString = "\(baseURL)/appointments"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
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
                
                let appointmentResponse = try decoder.decode(PatientAppointmentResponse.self, from:
                                                                data)
                                                                               DispatchQueue.main.async {
                                                                                   self.appointments = appointmentResponse.data
                                                                                   
                                                                                   if let dataString = String(data: data, encoding: .utf8) {
                                                                                       print("Raw JSON response: \(dataString)")
                                                                                   }
                                                                               }
                                                                           } catch {
                                                                               // Print detailed error information
                                                                               print("Error decoding appointments: \(error.localizedDescription)")
                                                                               if let dataString = String(data: data, encoding: .utf8) {
                                                                                   print("Raw JSON response: \(dataString)")
                                                                               }
                                                                           }
                                                                       }
                                                                       
                                                                       task.resume()
                                                                   }
                                                                   
                                                                   // Function to fetch lab test appointments
                                                                   func getLabAppointments(completion: @escaping (Bool) -> Void) {
                                                                       let urlString = "\(baseURL)/gettestappointments"
                                                                       guard let url = URL(string: urlString) else {
                                                                           print("Invalid URL")
                                                                           return
                                                                       }
                                                                       
                                                                       var request = URLRequest(url: url)
                                                                       request.httpMethod = "GET"
                                                                       request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                                                                       request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
                                                                       
                                                                       let task = URLSession.shared.dataTask(with: request) { data, response, error in
                                                                           if let error = error {
                                                                               print("Error fetching appointments: \(error.localizedDescription)")
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
                                                                               
                                                                               let appointmentResponse = try decoder.decode(GetAppointmentListResponse.self, from: data)
                                                                               DispatchQueue.main.async {
                                                                                   self.labAppointments = appointmentResponse.data
                                                                                   completion(true)
                                                                                   
                                                                                   if let dataString = String(data: data, encoding: .utf8) {
                                                                                       print("Raw JSON response: \(dataString)")
                                                                                   }
                                                                               }
                                                                           } catch {
                                                                               // Print detailed error information
                                                                               print("Error decoding appointments: \(error.localizedDescription)")
                                                                               if let dataString = String(data: data, encoding: .utf8) {
                                                                                   print("Raw JSON response: \(dataString)")
                                                                               }
                                                                               DispatchQueue.main.async {
                                                                                   completion(false)
                                                                               }
                                                                           }
                                                                       }
                                                                       
                                                                       task.resume()
                                                                   }
                                                                   
                                                                   // Function to book an emergency appointment
                                                                   func bookEmergency(description: String, completion: @escaping (Result<EmergencyResponse, Error>) -> Void) {
                                                                       guard let url = URL(string: "\(baseURL)/emergency") else {
                                                                           completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
                                                                           return
                                                                       }
                                                                       
                                                                       var request = URLRequest(url: url)
                                                                       request.httpMethod = "POST"
                                                                       request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                                                                       request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
                                                                       
                                                                       let parameters: [String: Any] = ["description": description]
                                                                       
                                                                       do {
                                                                           request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
                                                                       } catch {
                                                                           completion(.failure(error))
                                                                           return
                                                                       }
                                                                       
                                                                       URLSession.shared.dataTask(with: request) { data, response, error in
                                                                           if let error = error {
                                                                               completion(.failure(error))
                                                                               return
                                                                           }
                                                                           
                                                                           guard let data = data else {
                                                                               completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                                                                               return
                                                                           }
                                                                           
                                                                           do {
                                                                               let decoder = JSONDecoder()
                                                                               let response = try decoder.decode(EmergencyResponse.self, from: data)
                                                                               completion(.success(response))
                                                                           } catch {
                                                                               completion(.failure(error))
                                                                           }
                                                                       }.resume()
                                                                   }
                                                               }

