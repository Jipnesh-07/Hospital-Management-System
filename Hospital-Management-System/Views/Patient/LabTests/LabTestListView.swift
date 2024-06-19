//
//  LabTestListView.swift
//  Hospital-Management-System
//
//  Created by Ravneet Singh on 11/06/24.
//

import SwiftUI

struct LabTestAppointmentsView: View {
    @State private var isAddSheetPresented = false
    @State private var selectedSegment = 0 // 0 for Pending, 1 for Completed
    @StateObject private var patientService = PatientService()
    @State private var isLoading = true // State to track loading
    
    var filteredAppointments: [TestDetails] {
        if selectedSegment == 0 {
            return patientService.labAppointments.filter { $0.status == "Pending" }
                .sorted(by: { $0.date > $1.date }) // Sort by date in descending order
        } else {
            return patientService.labAppointments.filter { $0.status == "Completed" }
                .sorted(by: { $0.date > $1.date }) // Sort by date in descending order
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("Status", selection: $selectedSegment) {
                    Text("Pending").tag(0)
                    Text("Completed").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal, 16)
                
                if isLoading {
                    VStack {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                        
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity) // Center the loader vertically
                } else {
                    List(filteredAppointments) { appointment in
                        LabTestRow(appointment: appointment)
                            .listRowInsets(EdgeInsets())
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .navigationTitle("Appointments")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isAddSheetPresented = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $isAddSheetPresented) {
                BookLabAppointmentsView()
            }
            .onAppear {
                loadLabAppointments()
            }
        }
    }
    
    private func loadLabAppointments() {
        isLoading = true
        patientService.getLabAppointments { success in
            isLoading = false
        }
    }
}

struct LabTestRow: View {
    let appointment: TestDetails
    
    var body: some View {
        HStack {
            Text(appointment.testName)
                .font(.headline)
            
            Spacer()
            VStack(alignment: .trailing, spacing: 10) {
                Text(dateFormatter.string(from: appointment.date))
                    .font(.subheadline)
                Text(appointment.timeSlot)
                    .font(.callout)
                    .foregroundColor(.gray)
            }
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
        )
        .padding(.horizontal, 16)
        .padding(.vertical, 5)
    }
}

struct LabTestAppointmentsView_Previews: PreviewProvider {
    static var previews: some View {
        LabTestAppointmentsView()
    }
}






