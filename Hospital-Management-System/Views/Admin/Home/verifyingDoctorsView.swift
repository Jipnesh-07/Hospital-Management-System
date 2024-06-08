//
//  verifyingDoctorsView.swift
//  Hospital-Management-System
//
//  Created by MACBOOK on 08/06/24.
//

//import SwiftUI
//
//struct verifyingDoctorsView: View {
//    var body: some View {
//        VStack(alignment: .leading) {
//            Text("New Doctors")
//                .font(.headline)
//                .padding(.bottom, 5)
//            
//            HStack {
//                Image(systemName: "person.crop.circle")
//                    .resizable()
//                    .frame(width: 50, height: 50)
//                    .clipShape(Circle())
//                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
//                    .shadow(radius: 5)
//                
//                VStack(alignment: .leading) {
//                    Text("Dr Shreya Sharma")
//                        .font(.headline)
//                    Text("Dentist Specialist")
//                        .font(.subheadline)
//                        .foregroundColor(.gray)
//                }
//                Spacer()
//                Button(action: {
//                    // Approve button action
//                }) {
//                    Text("Approve")
//                        .padding(.horizontal)
//                        .padding(.vertical, 5)
//                        .background(Color.green)
//                        .foregroundColor(.white)
//                        .cornerRadius(5)
//                }
//                Button(action: {
//                    // Reject button action
//                }) {
//                    Text("Reject")
//                        .padding(.horizontal)
//                        .padding(.vertical, 5)
//                        .background(Color.red)
//                        .foregroundColor(.white)
//                        .cornerRadius(5)
//                }
//            }
//            .padding()
//            .background(Color.white)
//            .cornerRadius(10)
//            .shadow(radius: 1)
//        }
//        .padding(.bottom, 20)
//    }
//}
//
//#Preview {
//    verifyingDoctorsView()
//}
import SwiftUI

struct VerifyingDoctorsView: View {
    @State private var data: [Doctor] = []
    @State private var isLoading: Bool = false
    
    let adminService = AdminService()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("New Doctors")
                .font(.headline)
                .padding(.bottom, 5)
            
            if isLoading {
                ProgressView("Loading...")
            } else {
                ForEach(data, id: \.id) { doctor in
                    DoctorRow(doctor: doctor)
                }
            }
        }
        .padding()
        .onAppear {
            isLoading = true
            adminService.getDoctors { result in
                switch result {
                case .success(let doctorResponse):
                    DispatchQueue.main.async {
                        self.data = doctorResponse.data
                        isLoading = false
                    }
                case .failure(let error):
                    print("Failed to fetch doctors: \(error)")
                    // Handle error here
                    isLoading = false
                }
            }
        }
    }
}

struct DoctorRow: View {
    let doctor: Doctor
    let adminService = AdminService()
    
    var body: some View {
        HStack {
            Image(systemName: "person.crop.circle")
                .resizable()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 2))
                .shadow(radius: 5)
            
            VStack(alignment: .leading) {
                Text("\(doctor.firstName) \(doctor.lastName)")
                    .font(.headline)
                Text(doctor.specialization)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
            // Add approve and reject buttons here
            Button(action: {
                approveDoctor()
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
    
    func approveDoctor() {
           adminService.approveDoctor(doctorID: doctor.id) { result in
               switch result {
               case .success(let doctor):
                   print("Doctor approved successfully: \(doctor)")
                   // Handle success, if needed
               case .failure(let error):
                   print("Failed to approve doctor: \(error)")
                   // Handle error
               }
           }
       }
}

struct VerifyingDoctorsView_Previews: PreviewProvider {
    static var previews: some View {
        VerifyingDoctorsView()
    }
}



