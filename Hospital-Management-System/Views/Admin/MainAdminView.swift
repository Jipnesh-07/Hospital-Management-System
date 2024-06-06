//
//  MainAdminView.swift
//  Hospital-Management-System
//
//  Created by MACBOOK on 05/06/24.
//

import SwiftUI

struct MainAdminView: View {
    var body: some View {
        TabView {
            AdminHomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                    
                }
            
            DoctorsList_AdminView()
                .tabItem {
                    Label("Doctors", systemImage: "person.badge.clock")
                    
                }
            
            PatientsList_AdminView()
                .tabItem {
                    Label("Patients", systemImage: "person.2.fill")
                }
            
            
            LaboratoryTests_AdminView()
                .tabItem {
                    Label("LabTests", systemImage: "person")
                }
            
            
            
        }
    }
}

#Preview {
    MainAdminView()
}
