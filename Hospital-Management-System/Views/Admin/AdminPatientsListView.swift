import SwiftUI

struct AdminPatientsListView: View {
    @StateObject private var networkManager = NetworkManagerOfAdmin()
    @State private var searchText = ""
    
    var filteredPatients: [PatientForAdmin] {
        if searchText.isEmpty {
            return networkManager.patients
        } else {
            return networkManager.patients.filter {
                $0.firstName.lowercased().contains(searchText.lowercased()) ||
                $0.lastName.lowercased().contains(searchText.lowercased()) ||
                $0.id.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    var body: some View {
        //        NavigationView {
        VStack {
            // Custom search bar
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                    .padding(8)
                TextField("Search", text: $searchText)
                    .foregroundColor(.primary)
                    .padding(8)
            }
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .padding(.horizontal)
            .padding(.top, 8)
            
            List(filteredPatients) { patient in
                HStack {
                    VStack(alignment: .leading) {
                        // This could be the patient's profile picture
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                        
                        Spacer()
                    }
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("\(patient.firstName) \(patient.lastName)")
                            .font(.headline)
                        
                        Text("ID: \(patient.id)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                    }
                    .padding(.leading, 8)
                    
                    Spacer()
                    
                    // Navigation button or action button
                    NavigationLink(destination: PatientInformationAdminView(patient: patient)) {
                        //                                                    Image(systemName: "info.circle")
                        //                                                        .resizable()
                        //                                                        .frame(width: 24, height: 24)
                        //                                                        .foregroundColor(.blue)
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .shadow(radius: 2)
            }
            .listStyle(PlainListStyle())
        }
        .navigationTitle("Patients")
        //        }
        .onAppear {
            networkManager.getAllPatients()
        }
    }
}

struct AdminPatientsListView_Previews: PreviewProvider {
    static var previews: some View {
        AdminPatientsListView()
    }
}
