import SwiftUI

struct DoctorCategoryListPatientView: View {
    @State private var searchTitle: String = ""
    @State private var doctorsBySpecialization: [String: [Doctor]] = [:]
    
    // Mapping category names to image names and descriptions
    let categoryDetails: [String: (imageName: String, description: String)] = [
        "Cardiologist": ("heart", "Heart and Blood vessels"),
        "Dermatology": ("rash", "Skin, hair, and nails."),
        "Anesthesiology": ("heel", "Pain relief"),
        "Gastroenterology": ("stomach", "Digestive system disorders"),
        "Neurology": ("brain", "Brain and neurons"),
        "Gynecology": ("uterus", "Female reproductive system"),
        "Ophthalmology": ("read", "Eyes"),
        "Eye Specialist": ("read", "Eyes")
    ]
    
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
                            NavigationLink(destination: DoctorsListBookingView(doctors: doctorsBySpecialization[specialization] ?? [])) {
                                VStack(spacing: 16) {
                                    if let details = categoryDetails[specialization] {
                                        CategoryRowPatient(category: CategoryOfPatient(imageName: details.imageName, name: specialization, description: details.description))
                                    } else {
                                        CategoryRowPatient(category: CategoryOfPatient(imageName: "default", name: specialization, description: ""))
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    Spacer()
                }
            }
            .navigationTitle("Doctors")
            .background(Color(red: 243/255, green: 241/255, blue: 239/255))
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

struct CategoryRowPatient: View {
    var category: CategoryOfPatient
    
    var body: some View {
        HStack {
            Image(category.imageName)
                .resizable()
                .frame(width: 40, height: 40)
                .padding(.trailing, 8)
            
            VStack(alignment: .leading) {
                Text(category.name)
                    .font(.headline)
                    .foregroundColor(.black)
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
struct CategoryOfPatient: Identifiable {
    var id = UUID()
    var imageName: String
    var name: String
    var description: String
    
    init(id: UUID = UUID(), imageName: String, name: String, description: String) {
        self.id = id
        self.imageName = imageName
        self.name = name
        self.description = description
    }
}


struct DoctorsListBookingView: View {
    var doctors: [Doctor]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                ForEach(doctors) { doctor in
                    VStack(alignment: .leading) {
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
                                    Text("Fees:  \(doctor.fees)")
                                        .font(.system(size: 14))
                                        .fontWeight(.bold)
                                        .padding(9)
                                        .background(RoundedRectangle(cornerRadius: 12).stroke(Color.gray, lineWidth: 1))
                                    
                                    Spacer()
                                    
                                    NavigationLink(destination: DoctorInformationPatientView(viewModel: DoctorInformationViewModelPatient(doctor: doctor))) {
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
    }
}


#Preview {
    DoctorCategoryListPatientView()
}


