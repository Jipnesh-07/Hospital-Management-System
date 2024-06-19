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
            DoctorAppointmentView()
                .tabItem {
                    Label("Appointments", systemImage: "person.badge.clock")
                    
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
