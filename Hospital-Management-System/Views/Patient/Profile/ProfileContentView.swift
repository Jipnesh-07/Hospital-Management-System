//
//  ProfileContentView.swift
//  Hospital-Management-System
//
//  Created by MACBOOK on 05/06/24.
//

import SwiftUI

struct ProfileContentView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var isHealthDetailsPresented = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                HStack {
                    Spacer()
                    Button("Done") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                .padding()
                .background(Color(red: 241/255, green: 241/255, blue: 246/255))
                
                List {
                    VStack(spacing: 0) {
                        Image("doctor")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 75, height: 75)
                            .background(Color(.gray))
                            .clipShape(Circle())
                        
                        Text("Dr Rohan Sharma")
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                    }
                    .frame(maxWidth: .infinity, maxHeight: 150)
                    .background(Color(red: 241/255, green: 241/255, blue: 246/255))
                    .listRowInsets(EdgeInsets())
                    
                    Group {
                        NavigationLink(destination: HealthDetailsView()) {
                            Text("Personal information")
                        }
                        NavigationLink(destination: Text("Medical Credentials View")) {
                            Text("Medical Credentials")
                        }
                    }
                    
                    Section(header: Text("Features")
                        .font(.title3)
                        .textCase(.none)
                        .foregroundColor(.black)) {
                            NavigationLink(destination: Text("Subscriptions View")) {
                                Text("Subscriptions")
                            }
                            NavigationLink(destination: Text("Notifications View")) {
                                Text("Notifications")
                            }
                        }
                    
                    Section(header: Text("Privacy")
                        .font(.title3)
                        .textCase(.none)
                        .foregroundColor(.black)) {
                            NavigationLink(destination: Text("Apps and Services View")) {
                                Text("Apps and Services")
                            }
                            NavigationLink(destination: Text("Research Studies View")) {
                                Text("Research Studies")
                            }
                            NavigationLink(destination: Text("Devices View")) {
                                Text("Devices")
                            }
                        }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Your data is encrypted on your device and can only be shared with your permission.")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                            .padding(.horizontal, 14)
                            .padding(.bottom, 100)
                    }
                    .background(Color(red: 241/255, green: 241/255, blue: 246/255))
                    .listRowInsets(EdgeInsets())
                }
                .listStyle(GroupedListStyle())
            }
            .navigationBarBackButtonHidden(true)
            .sheet(isPresented: $isHealthDetailsPresented) {
                HealthDetailsView()
            }
        }
    }
}

#Preview {
    ProfileContentView()
}
