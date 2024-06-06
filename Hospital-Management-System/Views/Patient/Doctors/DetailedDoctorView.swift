//
//  DetailedDoctorView.swift
//  Hospital-Management-System
//
//  Created by MACBOOK on 05/06/24.
//

import SwiftUI

struct DetailedDoctorView: View {
    
//    @State private var shiftStartTime = Date()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Doctor's Profile Information
                VStack(spacing: 10) {
                    Image("user1")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                    
                    Text("James Harris")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Text("MBBS")
                        .foregroundColor(.gray)
                    
                    HStack{
                        Image(systemName: "clock")
                        Text("10:00am - 5:30pm")
                            .foregroundColor(.gray)
                    }
                    Divider()
                    Spacer().frame(height: 4)
                    HStack {
                        VStack {
                            Text("15yr")
                                .font(.title3)
                                .fontWeight(.bold)
                            Text("Experience")
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        VStack {
                            Text("₹450")
                                .font(.title3)
                                .fontWeight(.bold)
                            Text("Hourly Rate")
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.horizontal, 40)
                    
                    
                    Spacer().frame(height: 6)
                    // Date Selection
                    
                    VStack{
                        Text("About")
                            .font(.title3)
                            .bold()
                        Text("Dr. John Doe is a highly experienced cardiologist with over 15 years of experience in the field. He is dedicated to providing the best care to his patients.")
                            .font(.footnote)
                            .multilineTextAlignment(.center)
                            .lineLimit(3)
                            .padding(.horizontal)
                    }
                    VStack(alignment: .leading, spacing: 10) {
                        
                        Text("Appointment Schedule")
                            .font(.title3)
                            .bold()
                        
                        HStack{
                            VStack{
                                Text("Morning")
                                    .font(.headline)
                                Divider().frame(width: 100)
                                Text("08:00am")
                                    .font(.subheadline)
                                Text("11:30am")
                                    .font(.subheadline)
                            }
                            .padding(2)
                            .border(Color.black)
                            .cornerRadius(8)
                            
                            VStack{
                                Text("AfterNoon")
                                    .font(.headline)
                                Divider().frame(width: 100)
                                Text("08:00am")
                                    .font(.subheadline)
                                Text("11:30am")
                                    .font(.subheadline)
                            }
                            .padding(2)
                            .border(Color.black)
                            .cornerRadius(8)
                            .frame(maxWidth: .infinity)
                          
                            
                            
                            VStack{
                                Text("Evening")
                                    .font(.headline)
                                Divider().frame(width: 100)
                                Text("08:00am")
                                    .font(.subheadline)
                                Text("11:30am")
                                    .font(.subheadline)
                            }
                            .padding(2)
                            .border(Color.black)
                            .cornerRadius(8)
                          
                        }
                        
                        
               
                        
                    }
                    .padding(.horizontal)
                    
                    Spacer().frame(height: 10)
                    
                    // Book Appointment Button
                    Button(action: {
                        // Book appointment action
                    }) {
                        Text("Book Appointment")
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                }
                .padding()
                .background(.white)
                .cornerRadius(15)
                .shadow(color: Color.gray.opacity(0.5), radius: 10, x: 0, y: 5)
                .padding(.horizontal)
                
                
            }
        }
    }
}

#Preview {
    DetailedDoctorView()
}
