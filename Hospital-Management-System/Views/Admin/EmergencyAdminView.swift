

//
//  EmergencyAdminView.swift
//  Hospital-Management-System
//
//  Created by Ravneet Singh on 14/06/24.
//

import SwiftUI

struct EmergencyRequestsView: View {
    @StateObject private var viewModel = EmergencyRequestsViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                } else {
                    List(viewModel.emergencyRequests) { request in
                        EmergencyRequestRow(request: request)
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .navigationTitle("Emergency Requests")
            .onAppear {
                viewModel.fetchEmergencyRequests()
            }
        }
    }
}

struct EmergencyRequestRow: View {
    let request: EmergencyAdminRequest
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(request.patient.firstName) \(request.patient.lastName)")
                .font(.headline)
            Text("Age: \(request.patient.age), Gender: \(request.patient.gender)")
                .font(.subheadline)
                .foregroundColor(.secondary)
            Text("Blood Group: \(request.patient.bloodGroup)")
                .font(.subheadline)
                .foregroundColor(.secondary)
            Text("Description: \(request.description)")
                .font(.body)
                .padding(.top, 5)
            Text("Status: \(request.status)")
                .font(.body)
                .padding(.top, 5)
                .foregroundColor(request.status == "Pending" ? .orange : .green)
            Text("Timestamp: \(request.timestamp)")
                .font(.caption)
                .foregroundColor(.secondary)
                .padding(.top, 5)
        }
        .padding(.vertical, 10)
    }
}
