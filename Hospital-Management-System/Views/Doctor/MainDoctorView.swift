//
//  MainDoctorView.swift
//  Hospital-Management-System
//
//  Created by MACBOOK on 05/06/24.
//

import SwiftUI

struct MainDoctorView: View {
    var body: some View {
        TabView {
            
            DoctorHomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                    
                }
            
            DoctorAppointmentView()
                .tabItem {
                    Label("Appointments", systemImage: "person.badge.clock")
                    
                }
            
          //  PatientsListView()
                .tabItem {
                    Label("Patients", systemImage: "person.2.fill")
                }
            
            DoctorProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
            
            
            
        }
    }
}

#Preview {
    MainDoctorView()
}
