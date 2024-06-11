//
//  patientController.swift
//  Hospital-Management-System
//
//  Created by MACBOOK on 05/06/24.
//

import Foundation

import Combine

class PatientService:ObservableObject {
    let token: String = UserDefaults.standard.string(forKey: "authToken") ?? ""
        
        
        

    
//    let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImphdGluQHBhdGllbnQuY29tIiwiaWQiOiI2NjY0MjY4NjVmZGY5ODY5NmIyMGQ1MTYiLCJpYXQiOjE3MTc4NDEzMzV9.J4kybVsN9Z1O9axHGRU4pf65fNicwDEUrEsH2_2TV1Y"
    
    let baseURL = "https://hms-backend-1-1aof.onrender.com/patient"
    
    @Published var appointmentResult: Result<TestDetails, Error>? = nil
    
    @Published var appointments: [PatientAppointment] = []
    
    @Published var labAppointments: [TestDetails] = []
        
    
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
    
    
    func getAppointments() {
            let urlString = "\(baseURL)/appointments"
            guard let url = URL(string: urlString) else {
                print("Invalid URL")
                return
            }
        print("printing saveddddd token: \(token)")
            
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
                    
                    let appointmentResponse = try decoder.decode(PatientAppointmentResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.appointments = appointmentResponse.data
                        
                        if let dataString = String(data: data, encoding: .utf8) {
                            print("Raw JSON response: \(dataString)")
                        }
                    }
                } catch {
                    // Print detailed error information
                    print("data mapping error")
                    print("Error decoding appointments: \(error.localizedDescription)")
                    if let dataString = String(data: data, encoding: .utf8) {
                        print("Raw JSON response: \(dataString)")
                    }
                }
            }
            
            task.resume()
        }
    
    // Add a function to fetch appointments
    func getLabAppointments(completion: @escaping (Bool) -> Void) {
        print("entered get lab appointments ")
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
                    return
                }
                
                guard let data = data else {
                    print("No data received")
                    return
                }
            
//
                
                
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
                    print("data mapping error")
                    print("data mapping error")
                    print("Error decoding appointments: \(error.localizedDescription)")
                    if let dataString = String(data: data, encoding: .utf8) {
                        print("errror response: \(dataString)")
                    }
                    DispatchQueue.main.async {
                                        completion(false)
                                    }
                }
        }

        task.resume()
    }

}
