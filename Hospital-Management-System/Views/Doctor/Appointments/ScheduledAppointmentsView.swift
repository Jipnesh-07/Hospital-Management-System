//
//  PatientAppointmentsView.swift
//  Hospital-Management-System
//
//  Created by MACBOOK on 05/06/24.
//


import SwiftUI

//let dateFormatter: DateFormatter = {
//    let formatter = DateFormatter()
//    formatter.dateFormat = "dd MMM, yy"
//    return formatter
//}()

struct DoctorAppointmentView: View {
    
    @State private var searchText = ""
    @State private var selectedSegment = 0 // 0 for Pending, 1 for Completed
    @StateObject private var doctorService = DoctorService()
    
    var filteredAppointments: [DoctorAppointment] {
        let filteredBySegment: [DoctorAppointment]
        
        if selectedSegment == 0 {
            filteredBySegment = doctorService.appointments.filter { $0.status == "Pending" }.sorted(by: { $0.date > $1.date })
        } else {
            filteredBySegment = doctorService.appointments.filter { $0.status == "Completed" }.sorted(by: { $0.date > $1.date })
        }
        
        if searchText.isEmpty {
            return filteredBySegment
        } else {
            return filteredBySegment.filter { $0.patient.firstName.contains(searchText) || $0.patient.lastName.contains(searchText) }
        }
    }
    
    var body: some View {
        NavigationView {
            
            
            VStack {
                
                
                TextField("Search", text: $searchText)
                    .padding(10)
                    .padding(.horizontal, 24)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal, 16)
                    .overlay(
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 30)
                        }
                    )
                    .padding(.bottom, 10)
                Picker("Status", selection: $selectedSegment) {
                    Text("Pending").tag(0)
                    Text("Completed").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal, 16)
                
                List(filteredAppointments) { appointment in
                    DoctorRow(appointment: appointment)
                        .listRowInsets(EdgeInsets())
                }
                .listStyle(PlainListStyle())
                
                
            }
            
            .navigationTitle("Appointments")
            .onAppear {
                doctorService.getAppointments()
            }
        }
        
    }
    
    
    struct DoctorRow: View {
        let appointment: DoctorAppointment
        
        var body: some View {
            HStack {
                Image("user1") // Use a default image or a placeholder
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    .padding(.trailing, 10)
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("\(appointment.patient.firstName) \(appointment.patient.lastName)")
                        .font(.headline)
                    
                    
//                    Text("Symptom: \(appointment.symptom)")
//                        .font(.callout)
//                        .foregroundColor(.gray)
                }
                Spacer()
                VStack(alignment: .trailing, spacing: 4) {
                    Text(dateFormatter.string(from: appointment.date))
                        .font(.subheadline)
                    Text(appointment.timeSlot.rawValue)
                        .font(.subheadline)
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
    
    struct ProfileView_Previews: PreviewProvider {
        static var previews: some View {
            DoctorAppointmentView()
        }
    }
    
    
    }

