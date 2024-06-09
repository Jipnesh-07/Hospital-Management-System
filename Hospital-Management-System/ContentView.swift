//
//  ContentView.swift
//  Hospital-Management-System
//
//  Created by MACBOOK on 04/06/24.
//

import SwiftUI
import Combine

let authService = AuthService()

let patientService = PatientService()

let labAppointmentService = PatientService()
let adminservice = AdminService()

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
        //            //
        //            Button(action: {
        //                fetchDoctorAppointments(token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InJlZGR5QGdtYWlsLmNvbSIsImlkIjoiNjY1OGM2Y2IyM2M4ODIyNDQ2ZGJhMjhkIiwiaWF0IjoxNzE3MTM4MTE3fQ.LsLsCDLrhu5d30aX2kjxKA92IsQ9mIitvQxbdxyNPNY")
        //            }, label: {
        //                Text("get doctor appointment list")
        //            })
        //        }
        //        .padding()
        //
        //        Button(action: {
        //            authService.signup(firstName: "bhanu", lastName: "sharma", age: 10, gender: "Male", email: "bhanu@doctor.com", phoneNumber: 1234567890, password: "123456", accountType: "doctor", experience: 20){ result in
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
        //
        //
        //        Button(action: {
        //            authService.signin(email: "Jim@gmail.com", password: "123456") { result in
        //                switch result {
        //                case .success(let response):
        //                    print("User signed in successfully: \(response.user.firstName) \(response.user.lastName)")
        //                    print("Token: \(response.token)")
        //                case .failure(let error):
        //                    print("Error signing in: \(error)")
        //                }
        //            }}, label: {
        //                Text("SignIn")
        //            })
        //        MainPatientView()
        //        Button(action: {
        //            patientService.searchDoctors(query: "reddy") { result in
        //                switch result {
        //                case .success(let response):
        //                    print("Doctors found: \(response.data.count)")
        //                    for doctor in response.data {
        //                        print("Doctor: \(doctor.firstName) \(doctor.lastName), Specialization: \(doctor.accountType)")
        //                    }
        //                case .failure(let error):
        //                    print("Error searching doctors: \(error)")
        //                }
        //            }}, label: {
        //                Text("search")
        //            })
        //
        //        Button(action: {
        //            patientService.getDoctors { result in
        //                switch result {
        //                case .success(let response):
        //                    print("Doctors found: \(response.data.count)")
        //                    for doctor in response.data {
        //                        print("Doctor: \(doctor.firstName) \(doctor.lastName), Specialization: \(doctor.accountType)")
        //                    }
        //                case .failure(let error):
        //                    print("Error getting doctors: \(error)")
        //                }
        //            }}, label: {
        //                Text("get all approved doctors")
        //            })
        
        //        DoctorsListView()
        //                MainPatientView()
        //        MainDoctorView()
        //        MainAdminView()
        //        DetailedDoctorView()
        //        userSignIn()
        
        
        //    VerifyingDoctorsView()
        //        DoctorsListView()
        //    MainPatientView()
        //        userSignIn()
        //        bookLabAppointmentsView()
        //        Button(action: {
        //            patientService.bookLabAppointment(testName: "testing test nameapi tesingggg", timeSlot: "Evening", date: "2025-00-01") { result in
        //                DispatchQueue.main.async {
        //                    switch result {
        //                    case .success(let testDetails):
        //                        print("Appointment booked successfully: \(testDetails)")
        //                    case .failure(let error):
        //                        print("Failed to book appointment: \(error.localizedDescription)")
        //                    }
        //                }
        //            }
        //
        //                }, label: {
        //                     Text("book test")
        //                 })
        //
        //
        //
        ////        let apiUrl = "https://example.com/api/book-appointment" // Replace with the actual API URL
        //
        //
//        MainPatientView()
        
        userSignIn()
        //
        //
        //    }
    }
    //
    //#Preview {
    //    ContentView()
    //    @State private var testName = ""
    //        @State private var timeSlot = ""
    //        @State private var date = ""
    //        @State private var resultMessage = ""
    //
    //        @ObservedObject var patientService = PatientService()
    //
    //        var body: some View {
    //            VStack {
    //                TextField("Test Name", text: $testName)
    //                    .padding()
    //                    .textFieldStyle(RoundedBorderTextFieldStyle())
    //
    //                TextField("Time Slot", text: $timeSlot)
    //                    .padding()
    //                    .textFieldStyle(RoundedBorderTextFieldStyle())
    //
    //                TextField("Date", text: $date)
    //                    .padding()
    //                    .textFieldStyle(RoundedBorderTextFieldStyle())
    //
    //                Button(action: {
    //                    bookLabAppointment()
    //                }) {
    //                    Text("Book Appointment")
    //                        .padding()
    //                        .background(Color.blue)
    //                        .foregroundColor(.white)
    //                        .cornerRadius(8)
    //                }
    //                .padding()
    //
    //                Text(resultMessage)
    //                    .padding()
    //                    .foregroundColor(.red)
    //            }
    //            .padding()
    //            .onReceive(patientService.$appointmentResult) { result in
    //                guard let result = result else { return }
    //                switch result {
    //                case .success(let testDetails):
    //                    resultMessage = "Appointment booked successfully: \(testDetails)"
    //                case .failure(let error):
    //                    resultMessage = "Failed to book appointment: \(error.localizedDescription)"
    //                }
    //            }
    //        }
    //
    //        func bookLabAppointment() {
    //            patientService.bookLabAppointment(testName: testName, timeSlot: timeSlot, date: date)
    //        }
    //    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
