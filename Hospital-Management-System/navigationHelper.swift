//
//  navigationHelper.swift
//  Hospital-Management-System
//
//  Created by Ravneet Singh on 11/06/24.
//

import SwiftUI

enum UserType: String {
    case none
    case patient
    case doctor
    case admin
    case lab
}

struct NavigationHelper {
    
    static func destinationView(for userType: UserType) -> some View {
        switch userType {
        case .none:
            return AnyView(userSignIn())
        case .patient:
            return AnyView(MainPatientView())
        case .doctor:
            return AnyView(MainDoctorView())
        case .admin:
            return AnyView(MainAdminView())
        case .lab:
            return AnyView(LaboratoryContentView())
        }
    }
    
    static func getUserType(from accountType: String) -> UserType {
        switch accountType {
        case "patient":
            return .patient
        case "doctor":
            return .doctor
        case "admin":
            return .admin
        case "lab":
            return .lab
        default:
            return .none
        }
    }
}
