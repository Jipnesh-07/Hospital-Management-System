//
//  ProfileContentView.swift
//  Hospital-Management-System
//
//  Created by MACBOOK on 05/06/24.
//

import SwiftUI

struct ProfileContentView: View {
    @State private var isLoggedOut = false
    
    private func logout() {
        // Clear all data stored in UserDefaults
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "firstName")
        defaults.removeObject(forKey: "lastName")
        defaults.removeObject(forKey: "email")
        defaults.removeObject(forKey: "age")
        defaults.removeObject(forKey: "gender")
        defaults.removeObject(forKey: "bloodGroup")
        defaults.removeObject(forKey: "height")
        defaults.removeObject(forKey: "weight")
        defaults.removeObject(forKey: "authToken")
        defaults.removeObject(forKey: "userType")
        defaults.removeObject(forKey: "authToken")
        
        // Set isLoggedOut to true to trigger the navigation to sign-in screen
        isLoggedOut = true
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    ProfileHeaderView2()
                    
                    VStack(spacing: 1) {
                        NavigationLink(destination: PersonalInformationView2()) {
                            HStack {
                                Image(systemName: "person.circle")
                                    .foregroundColor(.blue)
                                Text("Personal Information")
                                    .foregroundColor(.black)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.gray)
                            }
                            .padding()
                            .background(Color.white)
                        }
                        
//                        NavigationLink(destination: AdminPatientsListView()) {
//                            HStack {
//                                Image(systemName: "person.3")
//                                    .foregroundColor(.blue)
//                                Text("Patients")
//                                    .foregroundColor(.black)
//                                Spacer()
//                                Image(systemName: "chevron.right")
//                                    .foregroundColor(.gray)
//                            }
//                            .padding()
//                            .background(Color.white)
//                        }
//                        
//                        NavigationLink(destination: AdminLabView()) {
//                            HStack {
//                                Image(systemName: "flask")
//                                    .foregroundColor(.blue)
//                                Text("Laboratory")
//                                    .foregroundColor(.black)
//                                Spacer()
//                                Image(systemName: "chevron.right")
//                                    .foregroundColor(.gray)
//                            }
//                            .padding()
//                            .background(Color.white)
//                        }
                    }
                    .background(Color(UIColor.systemGroupedBackground))
                    
                    VStack(spacing: 1) {
                        NavigationLink(destination: helpView()) {
                            HStack {
                                Image(systemName: "questionmark.circle")
                                    .foregroundColor(.blue)
                                Text("Help")
                                    .foregroundColor(.black)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.gray)
                            }
                            .padding()
                            .background(Color.white)
                        }
                        
                        NavigationLink(destination: privacyPolicy()) {
                            HStack {
                                Image(systemName: "lock.circle")
                                    .foregroundColor(.blue)
                                Text("Privacy Policy")
                                    .foregroundColor(.black)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.gray)
                            }
                            .padding()
                            .background(Color.white)
                        }
                    }
                    .background(Color(UIColor.systemGroupedBackground))
                    
                    Button(action: {
                        logout()
                    }) {
                        Text("Sign Out")
                            .foregroundColor(.red)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding()
                            .background(Color.white)
                    }
                }
                .padding(.top, 20)
                .fullScreenCover(isPresented: $isLoggedOut) {
                    userSignIn()
                }
            }
            .background(Color(UIColor.systemGroupedBackground))
            .navigationTitle("Account")
        }
    }
}

#Preview {
    ProfileContentView()
}




struct ProfileHeaderView2: View {
    let email: String = UserDefaults.standard.string(forKey: "email") ?? ""
    var body: some View {
        VStack {
            Image("user2")
                .resizable()
                .frame(width: 80, height: 80)
                .padding(.top, 40)
            
            Text(email)
                .font(.subheadline)
                .foregroundColor(.blue)
                .padding(.bottom, 20)
        }
        .frame(maxWidth: .infinity)
        .background(Color(UIColor.systemGroupedBackground))
    }
}

struct PersonalInformationView2: View {
    var body: some View {
        VStack{
          HealthDetailsView()
        }
    }
}

