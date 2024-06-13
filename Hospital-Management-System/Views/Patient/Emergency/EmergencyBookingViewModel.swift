//
//  EmergencyViewModel.swift
//  Hospital-Management-System
//
//  Created by Ravneet Singh on 14/06/24.
//

import Combine
import SwiftUI

class EmergencyBookingViewModel: ObservableObject {
    @Published var successMessage: String?
    @Published var errorMessage: String?
    @Published var isLoading = false
    
    private let patientService = PatientService()
    
    func bookEmergency(description: String) {
        isLoading = true
        successMessage = nil
        errorMessage = nil
        
        patientService.bookEmergency(description: description) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let response):
                    self?.successMessage = "Emergency request successfully submitted with ID: \(response.emergencyRequest._id)"
                case .failure(let error):
                    self?.errorMessage = "Failed to book emergency: \(error.localizedDescription)"
                }
            }
        }
    }
}
