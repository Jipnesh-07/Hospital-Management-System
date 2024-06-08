//
//  DoctorsList-AdminView.swift
//  Hospital-Management-System
//
//  Created by MACBOOK on 05/06/24.
//

import SwiftUI

struct DoctorsList_AdminView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("New Doctors")
                .font(.headline)
                .padding(.bottom, 5)
            
            HStack {
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    .shadow(radius: 5)
                
                VStack(alignment: .leading) {
                    Text("Dr Shreya Sharma")
                        .font(.headline)
                    Text("Dentist Specialist")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                Spacer()
                Button(action: {
                    // Approve button action
                }) {
                    Text("Approve")
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(5)
                }
                Button(action: {
                    // Reject button action
                }) {
                    Text("Reject")
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(5)
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 1)
        }
        .padding(.bottom, 20)
    }
}

#Preview {
    DoctorsList_AdminView()
}
