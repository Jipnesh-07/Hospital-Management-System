//
//  DoctorsListView.swift
//  Hospital-Management-System
//
//  Created by MACBOOK on 05/06/24.
//




import SwiftUI

struct DoctorsListView: View {
    @StateObject private var viewModel = DoctorsViewModel()
    @State private var searchText: String = ""
    @State private var selectedDoctor: Doctor?
//    var specialization: String
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack {
                    // Doctors Title
                    HStack {
                        Text("Doctors")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    
                    if let errorMessage = viewModel.errorMessage {
                        Text("Error: \(errorMessage)")
                            .foregroundColor(.red)
                            .padding()
                    } else {
                        ForEach(viewModel.data) { doctor in
                            DoctorList(doctor: doctor, selectedDoctor: $selectedDoctor)
//                        ForEach(viewModel.data.filter { $0.specialization == specialization }) { doctor in
//                                                   DoctorList(doctor: doctor, selectedDoctor: $selectedDoctor)
                        }
                    }
                }
                .padding()
            }
            .searchable(text: $searchText)
            .onAppear {
                viewModel.fetchDoctors()
            }
            .navigationTitle("Cardiologist")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarTitleDisplayMode(.inline)
            .sheet(item: $selectedDoctor) { selectedDoctor in // Show DetailedDoctorView when selectedDoctor is set
                DetailedDoctorView(doctor: selectedDoctor)
            }
        }
    }
}

struct DoctorList: View {
    var doctor: Doctor
        @Binding var selectedDoctor: Doctor?
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                if doctor.gender == "Male"{
                    Image("user1")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 2))
                }
                else{
                    Image("fDoctor")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 2))
                }
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("\(doctor.firstName) \(doctor.lastName)")
                        .font(.headline)
                    Text("\(doctor.qualification)")
                        .font(.subheadline)
                        .foregroundColor(.gray).bold()
                    Text("Exp: \(doctor.experience)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                Text("\(doctor.fees)")
                    .font(.headline)
            }
            
            
            
            Button(action: {
                selectedDoctor = doctor // Set the selected doctor when tapped
            }) {
                Text("Book Appointment")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(14)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: Color.gray.opacity(0.5), radius: 10, x: 0, y: 5)
        .padding(.horizontal)
        .padding(.vertical, 5)
    }
    
    
}

//#Preview {
//    DoctorsListView()
//}

//import Foundation
import Combine

class DoctorsViewModel: ObservableObject {
    @Published var data: [Doctor] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private var patientService = PatientService()
    
    func fetchDoctors() {
        isLoading = true
        patientService.getDoctors { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let response):
                    print("got doctors")
                    self?.data = response.data // Assuming DoctorResponse has a 'doctors' property
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}


#Preview {
    DoctorsListView()
}

