//
//  adminController.swift
//  Hospital-Management-System
//
//  Created by MACBOOK on 08/06/24.
//

import Foundation

class AdminService{
    let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImFkbWluQGhvc3BpdGFsLmNvbSIsImlkIjoiNjY2NDIxZmU1ZmRmOTg2OTZiMjBkNTA2IiwiaWF0IjoxNzE3ODM4Mzk1fQ.C8z_2Ky8CO66r-IdqNqvwkcdD60lGmPFReJoma75fUs"
    
    let baseURL = "https://hms-backend-1-1aof.onrender.com/admin"
    
    
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
    
    
    func approveDoctor(doctorID: String, completion: @escaping (Result<Doctor, Error>) -> Void) {
            let urlString = "\(baseURL)/doctors/\(doctorID)/approve"
            guard let url = URL(string: urlString) else {
                print("Invalid URL")
                return
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "PUT"
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
    
    
}


class NetworkManagerOfAdmin: ObservableObject {
    @Published var patients: [PatientForAdmin] = []
    
    func getAllPatients() {
        guard let url = URL(string: "https://hms-backend-1-1aof.onrender.com/admin/patients") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImFkbWluQGhvc3BpdGFsLmNvbSIsImlkIjoiNjY2NDIxZmU1ZmRmOTg2OTZiMjBkNTA2IiwiaWF0IjoxNzE3OTU5NDg5fQ.y_NH-WBnxFDfZLNJvxnI8zTxouAltKZa_JPAYvF7284", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                // Debug: Print raw JSON response
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("Raw JSON response: \(jsonString)")
                }
                
                do {
                    // Attempt to decode JSON response to a dictionary with "data" key
                    let decodedResponse = try JSONDecoder().decode(PatientForAdminResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.patients = decodedResponse.data
                        print("Fetched Patients: \(decodedResponse.data)")
                    }
                } catch {
                    // Print error if decoding fails
                    print("Error decoding response: \(error)")
                }
            } else if let error = error {
                print("HTTP Request Failed: \(error)")
            }
        }.resume()
    }
}

