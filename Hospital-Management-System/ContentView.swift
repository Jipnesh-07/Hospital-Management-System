//
//  ContentView.swift
//  Hospital-Management-System
//
//  Created by MACBOOK on 04/06/24.
//


import SwiftUI


let authService = AuthService()
let patientService = PatientService()
let doctorService = DoctorService()

struct ContentView: View {
    @State private var userType: UserType = .none
    let userTypefromLocal: String = UserDefaults.standard.string(forKey: "userType") ?? ""
    @State private var isAuthenticated = false

    var body: some View {
        Group {
            if isAuthenticated {
                NavigationHelper.destinationView(for: userType)
            } else {
                userSignIn()
            }
        }
        .onAppear {
            checkAuthentication()
            let finalUserType: () = updateUserType(userTypefromLocal)
        }
    }

    private func checkAuthentication() {
        if let token = UserDefaults.standard.string(forKey: "authToken"), !token.isEmpty {
            isAuthenticated = true
        } else {
            isAuthenticated = false
        }
    }
    private func updateUserType(_ type: String) {
        DispatchQueue.main.async {
            switch type {
            case "patient":
                userType = .patient
            case "doctor":
                userType = .doctor
            case "admin":
                userType = .admin
            case "lab":
                userType = .lab
            default:
                userType = .none
            }
            print("User type updated to: \(userType)")

//                showFullScreenCover = (userType != .none)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
    

}
