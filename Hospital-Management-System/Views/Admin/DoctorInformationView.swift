
import SwiftUI
import Combine

class DoctorInformationViewModel: ObservableObject {
    @Published var doctor: Doctor
    
    init(doctor: Doctor) {
        self.doctor = doctor
    }
}

struct DoctorInformationView: View {
    @ObservedObject var viewModel: DoctorInformationViewModel
    @State private var isEditing = false
    @State private var showingDocument = false
    @State private var showingApproveAlert = false
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
       
            ScrollView {
                VStack(spacing: 20) {
                    Image("jipnesh")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 4))
                        .shadow(radius: 10)
                    
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
                    
                   
                    
                   
                }
                .padding()
                .navigationTitle("Profile")
                .navigationBarTitleDisplayMode(.inline)
                
            
        }
    }
}

//struct InfoRow: View {
//    let label: String
//    let value: String
//    
//    var body: some View {
//        HStack {
//            Text(label)
//            Spacer()
//            Text(value)
//        }
//    }
//}

