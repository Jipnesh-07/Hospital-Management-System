//
//  MainAdminView.swift
//  Hospital-Management-System
//
//  Created by MACBOOK on 13/06/24.
//

import SwiftUI

struct MainAdminView: View {
    var body: some View {
        TabView {
           AdminHomeView()
               .tabItem {
                    Label("Home", systemImage: "house")
                    
                }
            
            DoctorApprovalList()
                 .tabItem {
                     Label("ApprovalList", systemImage: "person.fill.checkmark")
                 }
             
            
            DoctorCategoryListView()
                .tabItem {
                    Label("Doctors", systemImage: "list.clipboard.fill")
                    
                }
            
          
            
           AdminProfile()
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
            
            
            
        }
    }
}

struct MainAdminView_Previews: PreviewProvider {
    static var previews: some View {
        MainAdminView()
    }
}
