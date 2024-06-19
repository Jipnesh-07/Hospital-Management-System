
import SwiftUI

struct DoctorCategoryListView: View {
    @State private var searchTitle: String = ""
    @State private var doctorsBySpecialization: [String: [Doctor]] = [:]
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack {
                    // Categories Title
                    HStack {
                        Text("Categories")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.top, 8)
                    
                    // List of Categories
                    ForEach(doctorsBySpecialization.keys.sorted(), id: \.self) { specialization in
                        Section {
                            NavigationLink(destination: DoctorsListView(doctors: doctorsBySpecialization[specialization] ?? [])) {
                                VStack(spacing: 16) {
                                    CategoryRow(category: Category2(imageName: specialization, name: specialization, description: ""))
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    Spacer()
                }
            }
            .navigationTitle("Doctors")
            .searchable(text: $searchTitle)
            .onAppear {
                fetchDoctors()
            }
        }
    }
    
    func fetchDoctors() {
        let doctorCategory = DoctorAPI()
        doctorCategory.getDoctors { result in
            switch result {
            case .success(let doctorResponse):
                let approvedDoctors = doctorResponse.data.filter { $0.approved }
                let groupedDoctors = Dictionary(grouping: approvedDoctors, by: { $0.specialization })
                DispatchQueue.main.async {
                    doctorsBySpecialization = groupedDoctors
                }
            case .failure(let error):
                print("Error fetching doctors: \(error.localizedDescription)")
            }
        }
    }
}

struct CategoryRow: View {
    var category: Category2
    
    var body: some View {
        HStack {
            Image(category.imageName)
                .resizable()
                .frame(width: 40, height: 40)
                .padding(.trailing, 8)
            
            VStack(alignment: .leading) {
                Text(category.name)
                    .font(.headline)
                Text(category.description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(8)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
    }
}

// Data Model
struct Category2: Identifiable {
    var id = UUID()
    var imageName: String
    var name: String
    var description: String
}
let sampleCategories = [
    Category2(imageName: "heart", name: "Cardiologist", description: "Heart and Blood vessels"),
    Category2(imageName: "rash", name: "Dermatology", description: "Skin, hair, and nails."),
    Category2(imageName: "heel", name: "Anesthesiology", description: "Pain relief"),
    Category2(imageName: "stomach", name: "Gastroenterology", description: "Digestive system disorders"),
    Category2(imageName: "brain", name: "Neurology", description: "Brain and neurone"),
    Category2(imageName: "uterus", name: "Gynecology", description: "Female reproductive system"),
    Category2(imageName: "read", name: "Ophthalmology", description: "Eyes")
]





struct DoctorsListView: View {
    var doctors: [Doctor]
    @State private var searchText: String = ""
    
    // Computed property to filter doctors based on search text
    var filteredDoctors: [Doctor] {
        if searchText.isEmpty {
            return doctors
        } else {
            return doctors.filter { doctor in
                doctor.firstName.lowercased().contains(searchText.lowercased()) ||
                doctor.lastName.lowercased().contains(searchText.lowercased()) ||
                String(doctor.phoneNumber).contains(searchText)
            }
        }
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                ForEach(filteredDoctors) { doctor in
                    VStack(alignment: .leading) {
                        HStack {
                            VStack(alignment: .leading, spacing: 10) {
                                HStack {
                                    VStack {
                                        Image("user2") // Replace with your image
                                            .resizable()
                                            .frame(width: 90, height: 90)
                                            .clipShape(RoundedRectangle(cornerRadius: 9))
                                    }
                                    .padding(.top)
                                    
                                    Spacer()
                                    VStack(alignment: .trailing) {
                                        Text("\(doctor.firstName) \(doctor.lastName)")
                                            .font(.title3)
                                            .fontWeight(.medium)
                                        Text(String(doctor.phoneNumber))
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                        
                                        Text("\(doctor.specialization)")
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                        
                                        Text("\(doctor.experience)")
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                    }
                                }
                                .padding(.top, -9)
                                
                                Spacer().frame(height: 20)
                                HStack {
                                    Text("Fees:  \(doctor.fees)")
                                        .font(.system(size: 14))
                                        .fontWeight(.bold)
                                        .padding(9)
                                        .background(RoundedRectangle(cornerRadius: 12).stroke(Color.gray, lineWidth: 1))
                                    
                                    Spacer()
                                    
                                    NavigationLink(destination: DoctorInformationView(viewModel: DoctorInformationViewModel(doctor: doctor))) {
                                        Text("↓")
                                            .font(.system(size: 20))
                                            .frame(width: 24)
                                            .padding(12)
                                            .rotationEffect(Angle(degrees: 270))
                                            .foregroundColor(.white)
                                            .background(RoundedRectangle(cornerRadius: 10).stroke(Color.white, lineWidth: 1).fill(Color(red: 97/255, green: 120/255, blue: 187/255)))
                                    }
                                    .buttonStyle(BorderlessButtonStyle())
                                }
                            }
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 16).fill(Color.white))
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                        .padding(.horizontal)
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Doctors")
        .searchable(text: $searchText)
    }
}


#Preview {
    DoctorCategoryListView()
}
