////
////  PatientsListView.swift
////  Hospital-Management-System
////
////  Created by MACBOOK on 05/06/24.
////
//
//import SwiftUI
//
//struct PatientsListView: View {
//    @State private var searchText = ""
//    @State private var selectedTab = 0
//    @State private var patients = [Patient]()
//    @State private var selectedPatient: Patient?
//
//    struct PatientDetail: View {
//        let patient: Patient
//
//        var body: some View {
//            VStack {
//                Image(patient.imageName)
//                    .resizable()
//                    .frame(width: 100, height: 100)
//                    .clipShape(Circle())
//
//                Text(patient.name)
//                    .font(.title)
//
//                Text("Condition: \(patient.condition)")
//
//                Text("Time: \(patient.time)")
//            }
//            .navigationTitle(patient.name)
//        }
//    }
//
//    var body: some View {
//        NavigationView {
//            VStack {
//                TextField("Search", text: $searchText)
//                    .padding(7)
//                    .padding(.horizontal, 25)
//                    .background(Color(.systemGray6))
//                    .cornerRadius(8)
//                    .padding(.horizontal, 10)
//                    .overlay(
//                        HStack {
//                            Image(systemName: "magnifyingglass")
//                                .foregroundColor(.gray)
//                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
//                                .padding(.leading, 16)
//                        }
//                    )
//
//                Picker(selection: $selectedTab, label: Text("")) {
//                    Text("Pending").tag(0)
//                    Text("Completed").tag(1)
//                }
//                .pickerStyle(SegmentedPickerStyle())
//                .padding(.horizontal)
//
//                List {
//                    ForEach(filteredPatients()) { patient in
//                        NavigationLink(
//                            destination: selectedTab == 1 ? AnyView(CompleteAppointmentView(patient: patient)) : AnyView(PrescriptionForm(appointment: patient.appointment)),
//                            tag: patient,
//                            selection: $selectedPatient
//                        ) {
//                            HStack {
//                                Image(patient.imageName)
//                                    .resizable()
//                                    .frame(width: 40, height: 40)
//                                    .clipShape(Circle())
//
//                                VStack(alignment: .leading) {
//                                    Text(patient.name)
//                                        .font(.headline)
//                                    Text(patient.condition)
//                                        .font(.subheadline)
//                                }
//
//                                Spacer()
//
//                                Text(patient.time)
//                                    .font(.subheadline)
//                            }
//                            .padding(.vertical, 5)
//                        }
//                    }
//                }
//                .listStyle(PlainListStyle())
//            }
//            .navigationTitle("Appointments")
//            .navigationBarHidden(false)
//            .onAppear {
//                DispatchQueue.main.async {
//                    fetchData()
//                }
//            }
//
//        }
//    }
//
//    private func filteredPatients() -> [Patient] {
//        return patients.filter { patient in
//            let matchesSearchText = searchText.isEmpty || patient.name.lowercased().contains(searchText.lowercased())
//            let matchesTab = (selectedTab == 0 && !patient.isCompleted) || (selectedTab == 1 && patient.isCompleted)
//            return matchesSearchText && matchesTab
//        }
//    }
//
//    private func fetchData() {
//        guard let url = URL(string: "https://hms-backend-1-1aof.onrender.com/doctor/appointments/") else {
//            print("Invalid URL")
//            return
//        }
//
//        var request = URLRequest(url: url)
//        request.setValue("Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InJhdm5lZXRAZG9jdG9yLmNvbSIsImlkIjoiNjY2NDIzNzM1ZmRmOTg2OTZiMjBkNTBhIiwiaWF0IjoxNzE4MDE0NTg2fQ.Tmo_kkMIV5NYWqq-_DApz4a4TPyktIG-uwlYDaOO_3g", forHTTPHeaderField: "Authorization")
//
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            if let data = data {
//                do {
//                    let decodedResponse = try JSONDecoder().decode(ApiResponse.self, from: data)
//                    DispatchQueue.main.async {
//                        self.patients = decodedResponse.data.map { appointment in
//                            Patient(
//                                name: "\(appointment.patient.firstName) \(appointment.patient.lastName)",
//                                condition: appointment.symptom,
//                                time: appointment.timeSlot,
//                                imageName: "defaultImageName", // Replace with your logic for image names
//                                isCompleted: appointment.status == "Completed",
//                                appointment: appointment
//                            )
//                        }
//                    }
//                } catch {
//                    print("Decoding error: \(error)")
//                }
//            }
//        }.resume()
//    }
//}
//
//
//
//struct ApiResponse: Codable {
//    let success: Bool
//    let data: [Appointment]
//}
//
//struct Appointment: Codable {
//    let _id: String
//    let patient: PatientData
//    let symptom: String
//    let doctor: String
//    let date: String
//    let timeSlot: String
//    let status: String
//    let prescription: String
//    let tests: [String]
//    let createdAt: String
//    let updatedAt: String
//    let __v: Int
//}
//
//struct PatientData: Codable {
//    let _id: String
//    let firstName: String
//    let lastName: String
//    let age: Int
//    let gender: String
//}
//
//
//#Preview {
//    PatientsListView()
//}
