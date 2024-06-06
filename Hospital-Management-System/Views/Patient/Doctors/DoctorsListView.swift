//
//  DoctorsListView.swift
//  Hospital-Management-System
//
//  Created by MACBOOK on 05/06/24.
//

//import SwiftUI
//
//struct DoctorsListView: View {
//    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//    }
//}
//
//#Preview {
//    DoctorsListView()
//}

import SwiftUI

struct DoctorsListView: View {
    @State var searchText : String = ""
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false){
                VStack {
                    
                    // Doctors Title
                    HStack {
                        Text("Doctors")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    
                    // List of Doctors
                    
                    //                    VStack {
                    //                        ForEach(doctors) { doctor in
                    //                            DoctorList(doctor:  doctor)
                    //                        }
                    //                    }
//                    Section{
//                        NavigationLink(destination: DetailedDoctorView()){
//                            DoctorList()
//                        }
//                        NavigationLink(destination: DetailedDoctorView()){
//                            DoctorList()
//                        }
//                        NavigationLink(destination: DetailedDoctorView()){
//                            DoctorList()
//                        }
//                        NavigationLink(destination: DetailedDoctorView()){
//                            DoctorList()
//                        }
//                        NavigationLink(destination: DetailedDoctorView()){
//                            DoctorList()
//                        }
//                    }
                    DoctorList()
                }
            }
            .searchable(text: $searchText)
        }
        .navigationTitle("Cardiologist")
        .navigationBarTitleDisplayMode(.inline)
    }
}


struct DoctorList: View {
    //    var doctor: Doctor1
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            
            
            
            HStack {
                Image("user2")
                    .resizable()
                    .frame(width: 50, height: 50)
                
                    .clipShape(Circle())
                
                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                
                VStack(alignment: .leading) {
                    Text("Raghav Vanshi")
                        .font(.headline)
                    Text("MBBS,MD")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                Text("450")
                    .font(.headline)
            }
            
            HStack {
                Image(systemName: "clock")
                    .foregroundColor(.gray)
                Text("10:30am - 05:30pm")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .padding(.leading,55)
            .padding(.bottom,5)
            .padding(.top,-5)
                        Button(action: {
//                            fetchAppointments(token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InlvQGdtYWlsLmNvbSIsImlkIjoiNjY1ODQyNDBmNjQwYTcxZWM2NWMwNDFmIiwiaWF0IjoxNzE3MTM0OTY1fQ.DwP7aLTOIKhRJVdY49J01Zu0CMRPm37IgHW3MDMV25M")
                        }) {
                            NavigationLink(destination: DetailedDoctorView()){
                                    Text("Book Appointment")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                        .padding(14)
                                        .frame(maxWidth: .infinity)
                                        .background(Color.blue)
                                        .cornerRadius(10)
                                }
            
                        }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: Color.gray.opacity(0.5), radius: 10, x: 0, y: 5)
        .padding(.horizontal)
        .padding(.vertical,5)
        
    }
}


#Preview {
    DoctorsListView()
}


