//
//  HealthDetailsView.swift
//  Hospital-Management-System
//
//  Created by MACBOOK on 05/06/24.
//

import SwiftUI

struct HealthDetailsView: View {
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
                
                Form {
                    Section {
                        HStack {
                            Text("First Name")
                            Spacer()
                            Text("Maya")
                                .foregroundColor(.black)
                        }
                        .frame(height: 36)
                        
                        HStack {
                            Text("Last Name")
                            Spacer()
                            Text("Singh")
                                .foregroundColor(.black)
                        }
                        .frame(height: 36)
                        
                        HStack {
                            Text("Date of Birth")
                            Spacer()
                            Text("16 May 2003 (21)")
                                .foregroundColor(.black)
                        }
                        .frame(height: 40)
                        
                        HStack {
                            Text("Sex")
                            Spacer()
                            Text("Female")
                                .foregroundColor(.black)
                        }
                        .frame(height: 40)
                        
                        HStack {
                            Text("Blood Type")
                            Spacer()
                            Text("A+")
                                .foregroundColor(.black)
                        }
                        .frame(height: 40)
                        
                        HStack {
                            Text("Medications That Affect Heart Rate")
                            Spacer()
                            Text("0")
                                .foregroundColor(.black)
                        }
                        .frame(height: 40)
                        
                        
                        
                    }
                }
                .listStyle(InsetGroupedListStyle())
                
            }
            .background(Color(UIColor.systemGroupedBackground).edgesIgnoringSafeArea(.all))
        }
    }
}

#Preview {
    HealthDetailsView()
}


