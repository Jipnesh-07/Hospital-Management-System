//
//  ContentView.swift
//  Hospital-Management-System
//
//  Created by MACBOOK on 04/06/24.
//

import SwiftUI

let authService = AuthService()

let patientService = PatientService()



struct ContentView: View {
    var body: some View {
        //        VStack {
        //            Image(systemName: "globe")
        //                .imageScale(.large)
        //                .foregroundStyle(.tint)
        //            Text("Hello, world!")
        //
        //            Button(action: {
        //                fetchPatientAppointments(token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InlvQGdtYWlsLmNvbSIsImlkIjoiNjY1ODQyNDBmNjQwYTcxZWM2NWMwNDFmIiwiaWF0IjoxNzE3MTM0OTY1fQ.DwP7aLTOIKhRJVdY49J01Zu0CMRPm37IgHW3MDMV25M")
        //            }, label: {
        //                Text("Get patient appointment list")
        //            })
        ////
        //            Button(action: {
        //                fetchDoctorAppointments(token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InJlZGR5QGdtYWlsLmNvbSIsImlkIjoiNjY1OGM2Y2IyM2M4ODIyNDQ2ZGJhMjhkIiwiaWF0IjoxNzE3MTM4MTE3fQ.LsLsCDLrhu5d30aX2kjxKA92IsQ9mIitvQxbdxyNPNY")
        //            }, label: {
        //                Text("get doctor appointment list")
        //            })
        //        }
        //        .padding()
        
        //        Button(action: {
        //            authService.signup(firstName: "admin", lastName: ".", age: 10, gender: "Male", email: "admin@gmail.com", phoneNumber: 1234567890, password: "password", accountType: "admin", experience: 20){ result in
        //                switch result {
        //                case .success(let response):
        //                    print("User signed up successfully: \(response.user.firstName) \(response.user.lastName)")
        //                    print("Token: \(response.token)")
        //                case .failure(let error):
        //                    print("Error signing up: \(error)")
        //                }
        //            }
        //        }, label: {
        //            Text("SignUp")
        //        })
        
        
        //        Button(action: {
        //            authService.signin(email: "admin@gmail.com", password: "123456") { result in
        //                switch result {
        //                case .success(let response):
        //                    print("User signed in successfully: \(response.user.firstName) \(response.user.lastName)")
        //                    print("Token: \(response.token)")
        //                case .failure(let error):
        //                    print("Error signing in: \(error)")
        //                }
        //            }}, label: {
        //            Text("SignIn")
        //        })
        //        MainPatientView()
        //        Button(action: {
        //            patientService.searchDoctors(query: "reddy") { result in
        //                switch result {
        //                case .success(let response):
        //                    print("Doctors found: \(response.data.count)")
        //                    for doctor in response.data {
        //                        print("Doctor: \(doctor.firstName) \(doctor.lastName), Specialization: \(doctor.specialization)")
        //                    }
        //                case .failure(let error):
        //                    print("Error searching doctors: \(error)")
        //                }
        //            }}, label: {
        //            Text("search")
        //        })
        
        //        Button(action: {
        //            patientService.getDoctors { result in
        //                switch result {
        //                case .success(let response):
        //                    print("Doctors found: \(response.data.count)")
        //                    for doctor in response.data {
        //                        print("Doctor: \(doctor.firstName) \(doctor.lastName), Specialization: \(doctor.specialization)")
        //                    }
        //                case .failure(let error):
        //                    print("Error getting doctors: \(error)")
        //                }
        //            }}, label: {
        //            Text("get all approved doctors")
        //        })
        
        
//        MainPatientView()
        //        MainDoctorView()
        //        MainAdminView()
        DetailedDoctorView()
    }
}

#Preview {
    ContentView()
}
