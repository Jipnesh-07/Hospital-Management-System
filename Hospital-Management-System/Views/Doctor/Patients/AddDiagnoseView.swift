////
////  AddDiagnoseView.swift
////  Hospital-Management-System
////
////  Created by Ravneet Singh on 12/06/24.
////
//
//import SwiftUI
//
//struct AddDiagnoseView: View {
//    @Environment(\.presentationMode) var presentationMode
//    @State private var prescriptionText = ""
//    //var appointment: Appointment
//    
//    var body: some View {
//        NavigationView {
//            VStack(spacing: 0) {
//                VStack(spacing: 10) {
//                    Image("doctorr")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 75, height: 75)
//                        .clipShape(Circle())
//                        .overlay(
//                            Circle().stroke(Color.white, lineWidth: 2)
//                        )
//                        .padding(.top, -20)
//                    
//                    Form {
//                        Section {
//                            HStack {
//                                Text("First Name")
//                                Spacer()
//                                Text(appointment.patient.firstName)
//                                    .foregroundColor(.black)
//                            }
//                            .frame(height: 37)
//                            
//                            HStack {
//                                Text("Last Name")
//                                Spacer()
//                                Text(appointment.patient.lastName)
//                                    .foregroundColor(.black)
//                            }
//                            .frame(height: 37)
//                            
//                            HStack {
//                                Text("Sex")
//                                Spacer()
//                                Text(appointment.patient.gender)
//                                    .foregroundColor(.black)
//                            }
//                            .frame(height: 37)
//                            
//                            HStack {
//                                Text("Blood Group")
//                                Spacer()
//                                Text("A+") // Replace with actual blood group if available in appointment data
//                                    .foregroundColor(.black)
//                            }
//                            .frame(height: 37)
//                            
//                            HStack {
//                                Text("Date")
//                                Spacer()
//                                Text(appointment.date)
//                                    .foregroundColor(.black)
//                            }
//                            .frame(height: 37)
//                            
//                            HStack {
//                                Text("Time")
//                                Spacer()
//                                Text(appointment.timeSlot)
//                                    .foregroundColor(.black)
//                            }
//                            .frame(height: 37)
//                            
//                            HStack {
//                                Text("Symptoms")
//                                Spacer()
//                                Text(appointment.symptom)
//                                    .foregroundColor(.black)
//                            }
//                            .frame(height: 37)
//                        }
//                        
//                        Section(header: Text("Prescribe")
//                            .font(.title3)
//                            .foregroundColor(.black)
//                            .textCase(.none)
//                            .frame(maxWidth: .infinity, alignment: .leading)) {
//                            TextField("", text: $prescriptionText)
//                                .frame(height: 42)
//                                .padding(.leading, -20)
//                        }
//                        
//                        Section(header: Text("Lab test")
//                            .font(.title3)
//                            .foregroundColor(.black)
//                            .textCase(.none)
//                            .frame(maxWidth: .infinity, alignment: .leading)) {
//                            TextField("", text: .constant(""))
//                                .frame(height: 42)
//                        }
//                    }
//                    .listStyle(InsetGroupedListStyle())
//                    
//                    Spacer()
//                    
//                    Button(action: {
//                        addPrescription(prescription: prescriptionText)
//                        self.presentationMode.wrappedValue.dismiss()
//                    }) {
//                        Text("Submit")
//                            .frame(maxWidth: .infinity)
//                            .padding()
//                            .foregroundColor(.white)
//                            .background(Color.blue)
//                            .cornerRadius(10)
//                            .padding(.horizontal, 20)
//                    }
//                    .padding(.bottom, 20)
//                }
//                .background(Color(red: 241/255, green: 241/255, blue: 246/255))
//            }
//            .background(Color(red: 241/255, green: 241/255, blue: 246/255))
//        }
//    }
//    
//    func addPrescription(prescription: String) {
//        guard let url = URL(string: "https://hms-backend-1-1aof.onrender.com/doctor/prescription/\(appointment._id)") else {
//            print("Invalid URL")
//            return
//        }
//        
//        var request = URLRequest(url: url)
//        request.httpMethod = "PUT" // Assuming you are updating the prescription
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.setValue("Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InJhdm5lZXRAZG9jdG9yLmNvbSIsImlkIjoiNjY2NDIzNzM1ZmRmOTg2OTZiMjBkNTBhIiwiaWF0IjoxNzE4MDA4NjA3fQ.0orHIZjWTLx7BL0dDpP_YjZyaMOFIAACnnfWK_cxNsI", forHTTPHeaderField: "Authorization")
//        
//        let body: [String: Any] = [
//            "prescription": prescription
//        ]
//        
//        do {
//            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
//        } catch {
//            print("Failed to serialize JSON: \(error.localizedDescription)")
//            return
//        }
//        
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            if let error = error {
//                print("Error: \(error.localizedDescription)")
//                return
//            }
//            
//            guard let httpResponse = response as? HTTPURLResponse else {
//                print("Invalid response")
//                return
//            }
//            
//            if httpResponse.statusCode == 200 {
//                print("Prescription added successfully")
//                // Handle successful response
//                if let data = data {
//                    do {
//                        if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
//                            print("Response JSON: \(jsonResponse)")
//                        }
//                    } catch {
//                        print("Failed to parse JSON: \(error.localizedDescription)")
//                    }
//                }
//            } else {
//                print("Failed with status code: \(httpResponse.statusCode)")
//                // Handle failure response
//            }
//        }
//        
//        task.resume()
//    }
//}
//
////#Preview {
////    AddDiagnoseView()
////}
