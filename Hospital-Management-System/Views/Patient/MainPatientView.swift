//
//  MainPatientView.swift
//  Hospital-Management-System
//
//  Created by MACBOOK on 05/06/24.
//

import SwiftUI

struct MainPatientView: View {
    var body: some View {
        TabView{
            
            PatientHomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                    
                }
           DoctorCategoryListPatientView()
                .tabItem {
                    Label("Doctors", systemImage: "stethoscope")
                }
            
            
            PatientAppointmentVeiw()
                .tabItem {
                    Label("Appointments", systemImage: "testtube.2")
                }
            
//            LaboratoryContentView()
            LabTestAppointmentsView()
                .tabItem {
                    Label("LabTests", systemImage: "testtube.2")
                }
            
            
//            ProfileContentView()
            HealthDetailsView()
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
        }
        
        
        
    }
}


#Preview {
    MainPatientView()
}
