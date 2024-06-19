//
//  auth.swift
//  Hospital-Management-System
//
//  Created by MACBOOK on 05/06/24.
//

import Foundation

// Service class responsible for handling authentication requests
class AuthService {
    
    // Base URL for API endpoints
    let baseURL = "https://hms-backend-1-1aof.onrender.com/auth"
    
    // Function to handle user registration (sign-up)
    func signup(firstName: String, lastName: String, age: Int, gender: String, email: String, phoneNumber: Int, password: String, accountType: String, experience: Int, completion: @escaping (Result<UserRegistrationResponse, Error>) -> Void) {
        
        // Constructing the URL for the sign-up endpoint
        guard let url = URL(string: baseURL + "/signup") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Request body containing user information
        let body: [String: Any] = [
            "firstName": firstName,
            "lastName": lastName,
            "age": age,
            "gender": gender,
            "email": email,
            "phoneNumber": phoneNumber,
            "password": password,
            "accountType": accountType,
            "experience": experience
        ]
        
        do {
            // Convert body to JSON data
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        } catch {
            completion(.failure(error))
            return
        }
        
        // Perform the network request
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
                // Decode JSON response into UserRegistrationResponse object
                let decoder = JSONDecoder()
                // Custom Date Decoding Strategy
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                decoder.dateDecodingStrategy = .formatted(dateFormatter)
                
                let signupResponse = try decoder.decode(UserRegistrationResponse.self, from: data)
                completion(.success(signupResponse))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    // Function to handle user authentication (sign-in)
    func signin(email: String, password: String, completion: @escaping (Result<SigninResponse, Error>) -> Void) {
        
        // Constructing the URL for the sign-in endpoint
        guard let url = URL(string: baseURL + "/signin") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Request body containing user email and password
        let body: [String: Any] = [
            "email": email,
            "password": password
        ]
        
        do {
            // Convert body to JSON data
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        } catch {
            completion(.failure(error))
            return
        }
        
        // Perform the network request
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
                // Decode JSON response into SigninResponse object
                let decoder = JSONDecoder()
                // Custom Date Decoding Strategy
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                decoder.dateDecodingStrategy = .formatted(dateFormatter)
                
                let signinResponse = try decoder.decode(SigninResponse.self, from: data)
                completion(.success(signinResponse))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}

