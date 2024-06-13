//
//  EmergencyBookingView.swift
//  Hospital-Management-System
//
//  Created by MACBOOK on 14/06/24.
//


import SwiftUI

struct EmergencyBookingView: View {
    @StateObject private var viewModel = EmergencyBookingViewModel()
    @State private var description = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Emergency Booking")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 40)
            
            TextField("Enter emergency description", text: $description)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(8)
                .padding(.horizontal, 16)
            
            if viewModel.isLoading {
                ProgressView()
                    .padding()
            } else {
                Button(action: {
                    viewModel.bookEmergency(description: description)
                }) {
                    Text("Book Emergency")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.accentColor)
                        .cornerRadius(8)
                        .padding(.horizontal, 16)
                }
            }
            
            if let successMessage = viewModel.successMessage {
                Text(successMessage)
                    .foregroundColor(.green)
                    .padding()
            } else if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }
            
            Spacer()
        }
        .background(Color(.systemBackground))
        .navigationTitle("Emergency")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct EmergencyBookingView_Previews: PreviewProvider {
    static var previews: some View {
        EmergencyBookingView()
    }
}
