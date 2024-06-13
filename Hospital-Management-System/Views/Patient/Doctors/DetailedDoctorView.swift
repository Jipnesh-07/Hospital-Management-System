//
//  DetailedDoctorView.swift
//  Hospital-Management-System
//
//  Created by MACBOOK on 05/06/24.
//


import SwiftUI
import Combine

class DoctorInformationViewModelPatient: ObservableObject {
    @Published var doctor: Doctor
    @State private var showBookAppointmentView = false
    init(doctor: Doctor) {
        self.doctor = doctor
    }
}

struct DoctorInformationPatientView: View {
    @ObservedObject var viewModel: DoctorInformationViewModelPatient
    @State private var isEditing = false
    @State private var showingDocument = false
    @State private var showingApproveAlert = false
    @Environment(\.presentationMode) var presentationMode
    @State private var showBookAppointmentView = false
    
    
    
    var body: some View {
        //        NavigationView {
        ScrollView {
            VStack(spacing: 20) {
                if viewModel.doctor.gender == "Female" {
                    Image("user3")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 4))
                        .shadow(radius: 10)
                }
                else{
                    Image("user2")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 4))
                        .shadow(radius: 10)
                }
                Text("Personal information")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                VStack(spacing: 10) {
                    InfoRow(label: "Name", value: viewModel.doctor.firstName + " " + viewModel.doctor.lastName)
                    InfoRow(label: "Email", value: viewModel.doctor.email)
                    InfoRow(label: "Gender", value: viewModel.doctor.gender)
                    InfoRow(label: "Phone Number", value: String(viewModel.doctor.phoneNumber))
                    InfoRow(label: "Qualification", value: viewModel.doctor.qualification)
                    InfoRow(label: "Specialization", value: viewModel.doctor.specialization)
                    InfoRow(label: "Experience", value: viewModel.doctor.experience)
                    InfoRow(label: "Fees", value: viewModel.doctor.fees)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal)
                
                Text("About")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                Text(viewModel.doctor.about)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                //                HStack {
                //                    Text("Document")
                //                        .font(.headline)
                //                    Spacer()
                //                    Button(action: {
                //                        showingDocument.toggle()
                //                    }) {
                //                        Text("View Document")
                //                            .foregroundColor(.blue)
                //                    }
                //                    .sheet(isPresented: $showingDocument) {
                //                        DocumentView(imageName: viewModel.doctor.email)
                //                    }
                //                }
                //                .padding(.horizontal)
                
                HStack(spacing: 20) {
                    Button(action: {
                        showBookAppointmentView = true
                    }) {
                        Text("Book Appointment")
                            .frame(maxWidth: .infinity)
                            .fontWeight(.bold)
                            .padding()
                            .background(Color(red: 97/255, green: 120/255, blue: 187/255))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .padding(.horizontal)
                .sheet(isPresented: $showBookAppointmentView) {
                    BookAppointmentView(doctorId: viewModel.doctor.id)
                }
            }
            .padding()
            .navigationTitle("Profile")
//            .background(Color(red: 243/255, green: 241/255, blue: 239/255))
            //            .navigationBarItems(leading: Button(action: {
            //                presentationMode.wrappedValue.dismiss()
            //            }) {
            //                Image(systemName: "")
            //                    .foregroundColor(.blue)
            //            }, trailing: HStack {
            //                Button(action: {
            //                    // Share action
            //                }) {
            //                    Image(systemName: "square.and.arrow.up")
            //                        .foregroundColor(.blue)
            //                }
            //
            //            })
            .sheet(isPresented: $isEditing) {
                EditView(doctor: $viewModel.doctor, isEditing: $isEditing)
            }
        }
        //        }
    }
}

struct InfoRow: View {
    let label: String
    let value: String
    
    var body: some View {
        HStack {
            Text(label)
            Spacer()
            Text(value)
        }
    }
}

struct EditView: View {
    @Binding var doctor: Doctor
    @Binding var isEditing: Bool
    
    var body: some View {
        //        NavigationView {
        Form {
            Section(header: Text("Personal information")) {
                TextField("Name", text: $doctor.firstName)
                TextField("Last Name", text: $doctor.lastName)
                TextField("Email", text: $doctor.email)
                TextField("Gender", text: $doctor.gender)
                TextField("Phone Number", value: $doctor.phoneNumber, formatter: NumberFormatter())
                TextField("Qualification", text: $doctor.qualification)
                TextField("Specialization", text: $doctor.specialization)
                TextField("Experience", text: $doctor.experience)
                TextField("Fees", text: $doctor.fees)
            }
            
            Section(header: Text("About")) {
                TextField("About", text: $doctor.about)
            }
            
            Section(header: Text("Document")) {
                TextField("Document", text: $doctor.email)
            }
        }
        .navigationTitle("Edit Profile")
        .navigationBarItems(trailing: Button("Done") {
            isEditing = false
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        })
        //        }
    }
}

struct DocumentView: View {
    let imageName: String
    
    var body: some View {
        VStack {
            if let image = UIImage(named: imageName) {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding()
            } else {
                Text("Document image not found")
                    .foregroundColor(.red)
                    .padding()
            }
        }
    }
}
