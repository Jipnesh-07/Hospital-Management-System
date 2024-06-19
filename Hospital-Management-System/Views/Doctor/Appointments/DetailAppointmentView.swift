//
//  DetailAppointmentView.swift
//  Hospital-Management-System
//
//  Created by Ravneet Singh on 12/06/24.
//

import SwiftUI

struct PrescriptionForm: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var prescriptionText = ""
    @State private var testText = ""
    var appointment: DoctorAppointment
    @State private var showSuccessAlert = false
    @State private var alertMessage = ""
    @ObservedObject var doctorService = DoctorService() // Use DoctorService to handle data submission
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                VStack(spacing: 10) {
                    Image("doctorr")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 75, height: 75)
                        .clipShape(Circle())
                        .overlay(
                            Circle().stroke(Color.white, lineWidth: 2)
                        )
                        .padding(.top, -20)
                    
                    Form {
                        Section {
                            HStack {
                                Text("First Name")
                                Spacer()
                                Text(appointment.patient.firstName)
                                    .foregroundColor(.black)
                            }
                            .frame(height: 37)
                            
                            HStack {
                                Text("Last Name")
                                Spacer()
                                Text(appointment.patient.lastName)
                                    .foregroundColor(.black)
                            }
                            .frame(height: 37)
                            
                            HStack {
                                Text("Sex")
                                Spacer()
                                Text(appointment.patient.gender)
                                    .foregroundColor(.black)
                            }
                            .frame(height: 37)
                            
                            HStack {
                                Text("Blood Group")
                                Spacer()
                                Text("A+") // Replace with actual blood group if available in appointment data
                                    .foregroundColor(.black)
                            }
                            .frame(height: 37)
                            
                            HStack {
                                Text("Date")
                                Spacer()
                                Text(dateFormatter.string(from: appointment.date))
                                    .foregroundColor(.black)
                            }
                            .frame(height: 37)
                            
                            HStack {
                                Text("Time")
                                Spacer()
                                Text(appointment.timeSlot.rawValue)
                                    .foregroundColor(.black)
                            }
                            .frame(height: 37)
                            
                            HStack {
                                Text("Symptoms")
                                Spacer()
                                Text(appointment.symptom ?? "")
                                    .foregroundColor(.black)
                            }
                            .frame(height: 37)
                        }
                        
                        Section(header: Text("Prescribe")
                            .font(.title3)
                            .foregroundColor(.black)
                            .textCase(.none)
                            .frame(maxWidth: .infinity, alignment: .leading)) {
                                TextField("", text: $prescriptionText)
                                    .frame(height: 42)
                                    .padding(.leading, -20)
                            }
                        
                        Section(header: Text("Lab test")
                            .font(.title3)
                            .foregroundColor(.black)
                            .textCase(.none)
                            .frame(maxWidth: .infinity, alignment: .leading)) {
                                TextField("", text: $testText)
                                    .frame(height: 42)
                            }
                    }
                    .listStyle(InsetGroupedListStyle())
                    
                    Spacer()
                    
                    Button(action: {
                        doctorService.addPrescription(appointmentId: appointment.id, prescription: prescriptionText) { success in
                            if success {
                                // self.presentationMode.wrappedValue.dismiss()
                                alertMessage = "Your appointment has been booked"
                                showSuccessAlert = true
                            } else {
                                print("Failed to add prescription")
                            }
                        }
                        
                        
                        doctorService.addTest(appointmentId: appointment.id, test: testText) { success in
                            if success {
                                //self.presentationMode.wrappedValue.dismiss()
                            } else {
                                print("Failed to add prescription")
                            }
                        }
                    }) {
                        Text("Submit")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.accentColor)
                            .cornerRadius(10)
                            .padding(.horizontal, 20)
                    }
                    .padding(.bottom, 20)
                }
                .background(Color(red: 241/255, green: 241/255, blue: 246/255))
            }
            .background(Color(red: 241/255, green: 241/255, blue: 246/255))
        }
        
        .alert(isPresented: $showSuccessAlert) {
            Alert(
                title: Text("Success"),
                message: Text(alertMessage),
                dismissButton: .default(Text("OK")) {
                    presentationMode.wrappedValue.dismiss()
                }
            )
            
        }
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }
}
