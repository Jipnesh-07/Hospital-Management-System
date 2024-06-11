//
//  PatientHomeView.swift
//  Hospital-Management-System
//
//  Created by MACBOOK on 05/06/24.
//


import SwiftUI

struct PatientHomeView: View {
    @StateObject private var patientService = PatientService()
    @State private var showHealthDetails = false

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    // Header with user information
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Welcome back,")
                                .font(.headline)
                                .foregroundColor(.gray)
                            Text("\(UserDefaults.standard.string(forKey: "firstName") ?? "") \(UserDefaults.standard.string(forKey: "lastName") ?? "")")
                                .font(.title)
                                .fontWeight(.bold)
                        }
                        Spacer()
                        Button(action: {
                            showHealthDetails.toggle()
                        }) {
                            Image(systemName: "person.circle")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .foregroundColor(.blue)
                        }
                        .sheet(isPresented: $showHealthDetails) {
                            HealthDetailsView()
                        }
                    }
                    .padding(.horizontal)

                    // Recent Appointments
                    Text("Recent Appointments")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.horizontal)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(patientService.appointments.prefix(5)) { appointment in
                                AppointmentCardView(appointment: appointment)
                            }
                        }
                        .padding(.horizontal)
                    }

                    // Recent Lab Tests
                    Text("Recent Lab Tests")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.horizontal)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(patientService.labAppointments.prefix(5)) { test in
                                LabTestCardView(test: test)
                            }
                        }
                        .padding(.horizontal)
                    }

                    // Navigation links for more options
                    VStack(spacing: 16) {
                        NavigationLink(destination: BookAppointmentView(doctorId: "6666a762d01533c8f2a8ddde")) {
                            DashboardCardView(icon: "calendar", title: "Book Appointment", color: .blue)
                        }
                        
                        NavigationLink(destination: LabTestAppointmentsView()) {
                            DashboardCardView(icon: "doc.text", title: "View Lab Tests", color: .green)
                        }
                        
                        // Add more navigation links as needed
                    }
                    .padding(.horizontal)
                }
            }
            .navigationTitle("Dashboard")
        }
        .onAppear {
            // Fetch data when the view appears
            patientService.getAppointments()
            //patientService.getLabAppointments()
        }
    }
}

struct AppointmentCardView: View {
    let appointment: PatientAppointment
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(appointment.doctor.firstName)
                .font(.headline)
                .foregroundColor(.white)
            Text("\(appointment.date, formatter: dateFormatter)")
                .font(.subheadline)
                .foregroundColor(.white)
            Text(appointment.status)
                .font(.subheadline)
                .foregroundColor(.white)
        }
        .padding()
        .background(Color.blue)
        .cornerRadius(10)
        .shadow(radius: 5)
        .frame(width: 200, height: 120)
    }
}

struct LabTestCardView: View {
    let test: TestDetails
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(test.testName)
                .font(.headline)
                .foregroundColor(.white)
            Text("\(test.date, formatter: dateFormatter)")
                .font(.subheadline)
                .foregroundColor(.white)
            Text(test.status)
                .font(.subheadline)
                .foregroundColor(.white)
        }
        .padding()
        .background(Color.green)
        .cornerRadius(10)
        .shadow(radius: 5)
        .frame(width: 200, height: 120)
    }
}

struct DashboardCardView: View {
    let icon: String
    let title: String
    let color: Color
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(.white)
                .padding()
                .background(color)
                .cornerRadius(8)
            Text(title)
                .font(.headline)
                .foregroundColor(.primary)
            Spacer()
        }
        .padding()
        .background(Color(UIColor.systemBackground))
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

#Preview {
    PatientHomeView()
}
