//
//  EmergencyAdminViewModel.swift
//  Hospital-Management-System
//
//  Created by Ravneet Singh on 14/06/24.
//

import Combine
import SwiftUI

class EmergencyRequestsViewModel: ObservableObject {
    @Published var emergencyRequests: [EmergencyAdminRequest] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let adminService = AdminService()
    
    func fetchEmergencyRequests() {
        isLoading = true
        errorMessage = nil
        
        adminService.getEmergencyRequests { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let requests):
                    self?.emergencyRequests = requests
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
