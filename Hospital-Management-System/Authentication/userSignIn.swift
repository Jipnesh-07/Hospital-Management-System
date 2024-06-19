//
//  userSignIn.swift
//  Hospital-Management-System
//
//  Created by MACBOOK on 05/06/24.

import SwiftUI

// The main view struct for user sign-in
struct userSignIn: View {
    // State properties to hold the user input and manage view state
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var userType: UserType = .none
    @State private var showFullScreenCover = false
    @State private var showError = false
    @State private var errorMessage = ""
    private let authservice = AuthService()
    
    // Computed property to determine email field border color
    private var emailBorderColor: Color {
        return email.isEmpty ? .accentColor : .black
    }
    
    // Computed property to determine password field border color
    private var passwordBorderColor: Color {
        return password.isEmpty ? .accentColor : .black
    }
    
    // The body property defines the view's UI
    var body: some View {
        NavigationStack{
            VStack {
                Spacer().frame(height: 60) // Spacer for top padding
                
                // Welcome message
                Text("Welcome back")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 2)
                
                // Subtitle message
                Text("Step back into your medical journey with ease.")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 30)
                
                // Email text field with styling
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
                
                // Password secure field with styling
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
                
                // Forgot password button
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
                
                // Sign in button
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
                
                // Display error message if there is an error
                if showError {
                    Text(errorMessage)
                        .foregroundColor(.red)
                }
                
                Spacer() // Spacer for bottom padding
                
                // Sign up prompt
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
                
                // Navigation link to the appropriate view based on user type
                NavigationLink(destination: NavigationHelper.destinationView(for: userType).navigationBarBackButtonHidden(true), isActive: .constant(userType != .none)) {
                    EmptyView()
                }
                .navigationBarBackButtonHidden(true)
            }
        }
    }
    
    // Resets the user type to none
    private func resetUserType() {
        DispatchQueue.main.async {
            userType = .none
        }
    }
    
    // Checks if the input fields are filled
    private func checkInput() {
        if email.isEmpty || password.isEmpty {
            alertMessage = "Please fill in all required fields."
            showAlert = true
        } else {
            signIn()
        }
    }
    
    // Handles the sign-in process
    private func signIn() {
        authService.signin(email: email, password: password) { result in
            switch result {
            case .success(let response):
                // Save user details to UserDefaults upon successful sign-in
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
                
                // Update the user type based on the response
                updateUserType(response.accountType)
            case .failure(let error):
                // Handle sign-in error
                print("Error signing in: \(error)")
                self.showError = true
                self.errorMessage = "Incorrect Password"
            }
        }
    }
    
    // Updates the user type and triggers the navigation change
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
        }
    }
}

// Preview struct for SwiftUI previews
#Preview {
    userSignIn()
}

