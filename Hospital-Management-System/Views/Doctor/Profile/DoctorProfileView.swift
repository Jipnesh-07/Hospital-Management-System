//
//  DoctorProfileView.swift
//  Hospital-Management-System
//
//  Created by MACBOOK on 05/06/24.
//

import SwiftUI

struct DoctorProfileView: View {
    let firstName: String = UserDefaults.standard.string(forKey: "firstName") ?? ""
    
    let lastName: String = UserDefaults.standard.string(forKey: "lastName") ?? ""
    
    let email: String = UserDefaults.standard.string(forKey: "email") ?? ""
    
    let age: String = UserDefaults.standard.string(forKey: "age") ?? ""
    
    let gender: String = UserDefaults.standard.string(forKey: "gender") ?? ""
    
    let bloodGroup: String = UserDefaults.standard.string(forKey: "bloodGroup") ?? ""
    
    let height: String = UserDefaults.standard.string(forKey: "height") ?? ""
    
    let weight: String = UserDefaults.standard.string(forKey: "weight") ?? ""
    
    let licenseNumber: String = UserDefaults.standard.string(forKey: "licenseNumber") ?? ""
    
    let specialization: String = UserDefaults.standard.string(forKey: "specialization") ?? ""
    
    let experience: String = UserDefaults.standard.string(forKey: "experience") ?? ""
    
    @Environment(\.presentationMode) var presentationMode
    @State private var isLoggedOut = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                Spacer()
                HStack {
                    Spacer()
                    Image("user1")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 90, height: 87)
                        .background(Color(.gray))
                        .clipShape(Circle())
                    Spacer()
                }
                .padding(.vertical, 20)
                
                HStack {
                    Text("\(firstName) \(lastName)")
                        .font(.title)
                        .fontWeight(.semibold)
                }
                HStack {
                    Text(email)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)
                }
                
                Form {
                    Section {
                        HStack {
                            Text("Age")
                                .foregroundColor(.black)
                            Spacer()
                            Text(age)
                                .foregroundColor(.black)
                                .fontWeight(.semibold)
                        }
                        .frame(height: 40)
                        
                        HStack {
                            Text("Sex")
                            Spacer()
                            Text(gender)
                                .foregroundColor(.black)
                                .fontWeight(.semibold)
                        }
                        .frame(height: 40)
                        
                        //                        HStack {
                        //                            Text("Medical License no.")
                        //                            Spacer()
                        //                            Text(licenseNumber)
                        //                                .foregroundColor(.black)
                        //                                .fontWeight(.semibold)
                        //                        }
                        //                        .frame(height: 40)
                        
                        HStack {
                            Text("Specialisation")
                            Spacer()
                            Text(specialization)
                                .foregroundColor(.black)
                                .fontWeight(.semibold)
                        }
                        .frame(height: 40)
                        
                        HStack {
                            Text("Experience")
                            Spacer()
                            Text(experience)
                                .foregroundColor(.black)
                                .fontWeight(.semibold)
                        }
                        .frame(height: 40)
                    }
                    Section {
                        NavigationLink(destination: AddSchedule()) {
                            Text("Schedule")
                                .foregroundColor(.black).frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    
                    // Logout Button
                    Section {
                        Button(action: {
                            logout()
                        }) {
                            Text("Logout")
                                .foregroundColor(.red)
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                    }
                }
                .listStyle(InsetGroupedListStyle())
                .padding(.bottom, 20)
            }
            .background(Color(UIColor.systemGroupedBackground).edgesIgnoringSafeArea(.all))
            .fullScreenCover(isPresented: $isLoggedOut) {
                userSignIn()
            }
        }
    }
    
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
        defaults.removeObject(forKey: "specialization")
        defaults.removeObject(forKey: "licenseNumber")
        defaults.removeObject(forKey: "experience")
        
        // Set isLoggedOut to true to trigger the navigation to sign-in screen
        isLoggedOut = true
    }
}

#Preview {
    DoctorProfileView()
}
