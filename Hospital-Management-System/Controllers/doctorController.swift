//
//  doctorController.swift
//  Hospital-Management-System
//
//  Created by Ravneet Singh on 12/06/24.
//

import Foundation

class DoctorService: ObservableObject{
    let token: String = UserDefaults.standard.string(forKey: "authToken") ?? ""
    
    let baseURL = "https://hms-backend-1-1aof.onrender.com/doctor"
    
    @Published var appointments: [DoctorAppointment] = []
    
//    private func getAppointments() {
//        guard let url = URL(string: "https://hms-backend-1-1aof.onrender.com/doctor/appointments/") else {
//            print("Invalid URL")
//            return
//        }
//
//        var request = URLRequest(url: url)
//        request.setValue("Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InJhdm5lZXRAZG9jdG9yLmNvbSIsImlkIjoiNjY2NDIzNzM1ZmRmOTg2OTZiMjBkNTBhIiwiaWF0IjoxNzE4MDE0NTg2fQ.Tmo_kkMIV5NYWqq-_DApz4a4TPyktIG-uwlYDaOO_3g", forHTTPHeaderField: "Authorization")
//
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            if let data = data {
//                do {
//                    let decodedResponse = try JSONDecoder().decode(ApiResponse.self, from: data)
//                    DispatchQueue.main.async {
//                        self.patients = decodedResponse.data.map { appointment in
//                            Patient(
//                                name: "\(appointment.patient.firstName) \(appointment.patient.lastName)",
//                                condition: appointment.symptom,
//                                time: appointment.timeSlot,
//                                imageName: "defaultImageName", // Replace with your logic for image names
//                                isCompleted: appointment.status == "Completed",
//                                appointment: appointment
//                            )
//                        }
//                    }
//                } catch {
//                    print("Decoding error: \(error)")
//                }
//            }
//        }.resume()
//    }
    
    
    
    
    
    
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
                    
                    let appointmentResponse = try decoder.decode(DoctorAppointmentResponse.self, from: data)
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
    
    
}
