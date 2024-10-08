
import Foundation
import Combine

class DoctorApprovalModel: ObservableObject {
    @Published var doctorsForApprovalAndInTheDataBaseOfHospital: [Doctor] = []
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        fetchDoctors()
    }
    
    func fetchDoctors() {
        DoctorAPI.shared.getDoctors { [weak self] result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self?.doctorsForApprovalAndInTheDataBaseOfHospital = response.data.filter { !$0.approved }
                }
            case .failure(let error):
                print("Failed to fetch doctors: \(error.localizedDescription)")
            }
        }
    }
    
    func approveDoctor(_ doctor: Doctor) {
        let doctorID = doctor.id
        DoctorAPI.shared.approveDoctor(doctorID: doctorID) { [weak self] result in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    self?.fetchDoctors() // Refresh the list after approval
                }
            case .failure(let error):
                print("Failed to approve doctor: \(error.localizedDescription)")
            }
        }
    }
    
    func rejectDoctor(_ doctor: Doctor) {
        let doctorID = doctor.id
        DoctorAPI.shared.rejectDoctor(doctorID: doctorID) { [weak self] result in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    self?.fetchDoctors() // Refresh the list after rejection
                }
            case .failure(let error):
                print("Failed to reject doctor: \(error.localizedDescription)")
            }
        }
    }
}


import SwiftUI

struct DoctorApprovalList: View {
    @StateObject private var dataModel = DoctorApprovalModel()
    @State private var showingConfirmation = false
    @State private var confirmationType: ConfirmationType = .approve
    @State private var selectedDoctor: Doctor?
    @State private var searchText: String = ""
    
    var filteredDoctors: [Doctor] {
        if searchText.isEmpty {
            return dataModel.doctorsForApprovalAndInTheDataBaseOfHospital
        } else {
            return dataModel.doctorsForApprovalAndInTheDataBaseOfHospital.filter {
                $0.firstName.localizedCaseInsensitiveContains(searchText) ||
                $0.specialization.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    enum ConfirmationType {
        case approve
        case reject
    }
    
    func handleDoctorAction(_ doctor: Doctor, action: ConfirmationType) {
        switch action {
        case .approve:
            dataModel.approveDoctor(doctor)
        case .reject:
            dataModel.rejectDoctor(doctor)
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Doctors")) {
                    if filteredDoctors.isEmpty {
                        Text("No doctors found.")
                            .foregroundColor(.gray)
                    } else {
                        ForEach(filteredDoctors) { doctor in
                            DoctorListItemView(doctor: doctor, onApprove: {
                                selectedDoctor = doctor
                                confirmationType = .approve
                                showingConfirmation = true
                            }, onReject: {
                                selectedDoctor = doctor
                                confirmationType = .reject
                                showingConfirmation = true
                            }, onInfo: {
                                selectedDoctor = doctor
                            })
                        }
                    }
                }
            }
            .navigationTitle("Pending Approval")
            .searchable(text: $searchText)
            .alert(isPresented: $showingConfirmation) {
                Alert(
                    title: Text(confirmationType == .approve ? "Approve Doctor" : "Reject Doctor"),
                    message: Text("Are you sure you want to \(confirmationType == .approve ? "approve" : "reject") this doctor?"),
                    primaryButton: .destructive(Text(confirmationType == .approve ? "Approve" : "Reject")) {
                        if let doctor = selectedDoctor {
                            handleDoctorAction(doctor, action: confirmationType)
                        }
                    },
                    secondaryButton: .cancel()
                )
            }
        }
        .onAppear {
            DispatchQueue.main.async {
                dataModel.fetchDoctors()
            }
        }
    }
}

struct DoctorListItemView: View {
    var doctor: Doctor
    var onApprove: () -> Void
    var onReject: () -> Void
    var onInfo: () -> Void
    
    var body: some View {
        
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    VStack {
                        if doctor.gender == "Male"{
                            Image("user2") // Replace with your image
                                .resizable()
                                .frame(width: 90, height: 90)
                                .clipShape(RoundedRectangle(cornerRadius: 9))
                        }
                        else{
                            Image("user3") // Replace with your image
                                .resizable()
                                .frame(width: 90, height: 90)
                                .clipShape(RoundedRectangle(cornerRadius: 9))
                        }
                    }
                    .padding(.top)
                    
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text("\(doctor.firstName) \(doctor.lastName)")
                            .font(.title3)
                            .fontWeight(.medium)
                        
                        Text("\(doctor.specialization)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        
                        Text("\(doctor.experience)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
                .padding(.top, -9)
                
                Spacer().frame(height: 10)
                HStack {
                    Button(action: onApprove) {
                        Text("Approve")
                            .padding(.vertical, 3)
                            .padding(.horizontal, 10)
                            .frame(minWidth: 110)
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(20)
                    }
                    .buttonStyle(BorderlessButtonStyle())
                    
                    Spacer()
                    
                    Button(action: onReject) {
                        Text("Reject")
                            .padding(.vertical, 3)
                            .padding(.horizontal, 10)
                            .frame(minWidth: 110)
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(20)
                    }
                    .buttonStyle(BorderlessButtonStyle())
                    
                    NavigationLink(destination: DoctorInformationView(viewModel: DoctorInformationViewModel(doctor: doctor))) {
                        //                        Text("↓")
                        //                            .font(.system(size: 20))
                        //                            .frame(width: 24)
                        //                            .padding(12)
                        //                            .rotationEffect(Angle(degrees: 270))
                        //                            .foregroundColor(.white)
                        //                            .background(RoundedRectangle(cornerRadius: 10).stroke(Color.white, lineWidth: 1).fill(Color(red: 97/255, green: 120/255, blue: 187/255)))
                    }
                    .buttonStyle(BorderlessButtonStyle())
                }
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 16).fill(Color.white))
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
        .padding(.horizontal)
        
        //        HStack {
        //            Image(systemName: "person.crop.circle.fill")
        //                .resizable()
        //                .frame(width: 50, height: 50)
        //                .clipShape(Circle())
        //
        //            VStack(alignment: .leading) {
        //                Text("\(doctor.firstName) \(doctor.lastName)")
        //                    .font(.headline)
        //                    .frame(minWidth: 150)
        //                    .padding(.bottom, 10)
        //                Text(doctor.specialization)
        //                    .font(.subheadline)
        //                    .padding(.bottom, 10)
        //                HStack {
        //                    Button(action: onApprove) {
        //                        Text("Approve")
        //                            .padding(.vertical, 3)
        //                            .padding(.horizontal, 10)
        //                            .frame(minWidth: 110)
        //                            .background(Color.green)
        //                            .foregroundColor(.white)
        //                            .cornerRadius(20)
        //                    }
        //                    .buttonStyle(BorderlessButtonStyle())
        //
        //                    Button(action: onReject) {
        //                        Text("Reject")
        //                            .padding(.vertical, 3)
        //                            .padding(.horizontal, 10)
        //                            .frame(minWidth: 110)
        //                            .background(Color.red)
        //                            .foregroundColor(.white)
        //                            .cornerRadius(20)
        //                    }
        //                    .buttonStyle(BorderlessButtonStyle())
        //                }
        //            }
        //
        //            Spacer()
        //
        //            NavigationLink(destination: DoctorInformationView(viewModel: DoctorInformationViewModel(doctor: doctor))) {
        //                Image(systemName: "info.circle")
        //                    .foregroundColor(.blue)
        //                    .padding()
        //            }
        //            .buttonStyle(BorderlessButtonStyle())
        //        }
    }
}
