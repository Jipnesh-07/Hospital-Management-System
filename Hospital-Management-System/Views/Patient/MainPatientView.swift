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
            CategoriesListView()
                .tabItem {
                    Label("Doctors", systemImage: "stethoscope")
                }
            
            
            LaboratoryContentView()
                .tabItem {
                    Label("Appointments", systemImage: "testtube.2")
                }
            
            LaboratoryContentView()
                .tabItem {
                    Label("LabTests", systemImage: "testtube.2")
                }
            
            
            ProfileContentView()
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
        }
        
        
        
    }
}


#Preview {
    MainPatientView()
}
