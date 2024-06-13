//
//  userSignIn.swift
//  Hospital-Management-System
//
//  Created by MACBOOK on 05/06/24.


import SwiftUI

//enum UserType: String {
//    case none
//    case patient
//    case doctor
//    case admin
//    case lab
//}


struct userSignIn: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var userType: UserType = .none
    @State private var showFullScreenCover = false
    
    private let authservice = AuthService()
    
    private var emailBorderColor: Color {
        return email.isEmpty ? .red : .black
    }
    
    private var passwordBorderColor: Color {
        return password.isEmpty ? .red : .black
    }
    
    
    var body: some View {
        NavigationStack{
            VStack {
                Spacer().frame(height: 60)
                
                Text("Welcome back")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 2)
                
                Text("Step back into your medical journey with ease.")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 30)
                
                TextField("Email*", text: $email)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .overlay(
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(emailBorderColor, lineWidth: 1)
                    )
                    .cornerRadius(14)
                    .padding(.horizontal, 30)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                
                
                SecureField("Password*", text: $password)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .overlay(
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(passwordBorderColor, lineWidth: 1)
                    )
                    .cornerRadius(14)
                    .padding(.horizontal, 30)
                    .padding(.top, 10)
                
                HStack {
                    Spacer()
                    Button(action: {
                        // Handle forgot password action
                    }) {
                        Text("Forgot Password?")
                            .font(.subheadline)
                            .foregroundColor(.blue)
                            .padding(.top, 10)
                            .padding(.trailing, 30)
                    }
                }
                
                Button(action: {
                    checkInput()
                }) {
                    Text("Sign in")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(.accent)
                        .cornerRadius(10)
                        .padding(.horizontal, 30)
                        .padding(.top, 20)
                }
                
                Spacer()
                
                HStack {
                    Text("Don’t have an account?")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    Button(action: {
                        // Handle sign up action
                    }) {
                        NavigationLink(destination: UserSignUp()){
                            Text("Sign up")
                                .font(.subheadline)
                                .foregroundColor(.blue)
                        }
                    }
                }
                .padding(.bottom, 20)
                NavigationLink(destination: NavigationHelper.destinationView(for: userType).navigationBarBackButtonHidden(true), isActive: .constant(userType != .none)) {
                                    EmptyView()
                                }
                                .navigationBarBackButtonHidden(true)
                                
            }

        }
    }
        
//        @ViewBuilder
//        private func destinationView() -> some View {
//            switch userType {
//            case .none:
//                EmptyView()
//            case .patient:
//                MainPatientView().onDisappear { resetUserType() }
//            case .doctor:
//                MainDoctorView().onDisappear { resetUserType() }
//            case .admin:
//                MainAdminView().onDisappear { resetUserType() }
//            case .lab:
//                LaboratoryContentView().onDisappear { resetUserType() }
//            }
//        }
        
    
    private func resetUserType() {
          DispatchQueue.main.async {
              userType = .none
          }
      }
    
        private func checkInput() {
            if email.isEmpty || password.isEmpty {
                alertMessage = "Please fill in all required fields."
                showAlert = true
            } else {
                signIn()
            }
        }
        private func signIn() {
            authService.signin(email: email, password: password) { result in
                switch result {
                case .success(let response):
                    print("User signed in successfully: \(response.user.firstName) \(response.user.lastName)")
                    print("Token: \(response.token)")
                    print("Type: \(response.accountType)")
                    
                    if response.accountType == "doctor" {
                        UserDefaults.standard.set(response.user.licenseNumber, forKey: "licenseNumber")
                        
                        UserDefaults.standard.set(response.user.specialization, forKey: "specialization")
                        
                        UserDefaults.standard.set(response.user.experience, forKey: "experience")
                    }
                    
                    
                    UserDefaults.standard.set(response.token, forKey: "authToken")
                    
                    UserDefaults.standard.set(response.accountType, forKey: "userType")
                    UserDefaults.standard.set(response.user.email, forKey: "email")
                    UserDefaults.standard.set(response.user.age, forKey: "age")
                    UserDefaults.standard.set(response.user.phoneNumber, forKey: "phoneNumber")
                    UserDefaults.standard.set(response.user.gender, forKey: "gender")
                    UserDefaults.standard.set(response.user.firstName, forKey: "firstName")
                    UserDefaults.standard.set(response.user.bloodGroup, forKey: "bloodGroup")
                    UserDefaults.standard.set(response.user.height, forKey: "height")
                    UserDefaults.standard.set(response.user.weight, forKey: "weight")
                    
                    
                    updateUserType(response.accountType)
                case .failure(let error):
                    print("Error signing in: \(error)")
                }
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

#Preview {
    userSignIn()
}


