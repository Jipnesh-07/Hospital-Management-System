//
//  DoctorHomeView.swift
//  Hospital-Management-System
//
//  Created by MACBOOK on 05/06/24.
//

import SwiftUI
import Combine

// Data Model
struct Doctor2: Codable {
    let success: Bool
    let data: DoctorData
}

struct DoctorData: Codable {
    let id: String
    let accountType: String
    let firstName: String
    let lastName: String
    let age: Int
    let gender: String
    let phoneNumber: Int
    let approved: Bool
    let email: String
    let about: String
    let specialization: String
    let experience: String
    let qualification: String
    let appointments: [String]
    let labTestAppointments: [String]
    let schedule: [Schedule2]
    let createdAt: String
    let updatedAt: String
    let fees: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case accountType, firstName, lastName, age, gender, phoneNumber, approved, email, about, specialization, experience, qualification, appointments, labTestAppointments, schedule, createdAt, updatedAt, fees
    }
}

struct Schedule2: Codable {
    let date: String
    let slots: [Slot]
}

struct Slot: Codable {
    let timeSlot: String
    let startTime: String
    let endTime: String
}

// API Service
class APIService: ObservableObject {
    @Published var doctorData: DoctorData?
    
    private var cancellable: AnyCancellable?
    
    func fetchDoctorData() {
        guard let url = URL(string: "https://hms-backend-1-1aof.onrender.com/doctor/getprofile") else { return }
        
        var request = URLRequest(url: url)
        request.setValue("Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InJhdm5lZXRAZG9jdG9yLmNvbSIsImlkIjoiNjY2NDIzNzM1ZmRmOTg2OTZiMjBkNTBhIiwiaWF0IjoxNzE4MDA4NjA3fQ.0orHIZjWTLx7BL0dDpP_YjZyaMOFIAACnnfWK_cxNsI", forHTTPHeaderField: "Authorization")
        
        cancellable = URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: Doctor2.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] doctor in
                self?.doctorData = doctor.data
            })
    }
}

// SwiftUI View
struct DoctorHomeView: View {
    @StateObject private var apiService = APIService()
    @State private var isPresentingContentView = false
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
                    HStack {
                        TextField("Search", text: .constant(""))
                            .padding(10)
                            .background(Color(.systemGray5))
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                    .padding(.bottom,10)
                    
                    HStack{
                        Text("Working hours")
                            .font(.title2)
                            .fontWeight(.semibold)
                        Spacer()
                        Button(action: {
                            isPresentingContentView.toggle()
                        }) {
                            Text("⊕")
                                .font(.title2)
                                .fontWeight(.medium)
                                .foregroundColor(.blue)
                        }
                    }
                    .padding(.horizontal)
                    
                    if let schedule = apiService.doctorData?.schedule.first {
                        VStack(spacing: 12){
                            ForEach(schedule.slots, id: \.startTime) { slot in
                                HStack{
                                    Text(slot.timeSlot)
                                        .fontWeight(.semibold)
                                    Spacer()
                                    Text("\(slot.startTime) - \(slot.endTime)")
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color(.darkGray))
                                }
                                .padding(.horizontal,12)
                                .padding(.top)
                            }
                        }
                        .padding(.horizontal)
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2)
                        .padding(.horizontal)
                    }
                    
                    HStack {
                        Text("Today Patients")
                            .font(.headline)
                            .foregroundColor(.gray)
                        Spacer()
                        Text("See all")
                            .foregroundColor(.blue)
                    }
                    .padding(.horizontal)
                    
                    // Assuming you will have a way to fetch and map patient data
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            PatientCard(name: "Rajesh", condition: "Heart attack", date: "5 June", time: "10:30 pm", imageName: "Image")
                            PatientCard(name: "Lily", condition: "Severe knee pain", date: "6 June", time: "10:30 pm", imageName: "Image2")
                        }
                        .padding(.horizontal)
                        .frame(height: 145)
                    }
                    
                    HStack {
                        Text("Attended Patients")
                            .font(.headline)
                            .foregroundColor(.gray)
                        Spacer()
                        Text("See all")
                            .foregroundColor(.blue)
                    }
                    .padding(.horizontal)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 30) {
                            AttendedPatientCard(name: "Sameer", condition: "Heart attack", imageName: "person.circle")
                            AttendedPatientCard(name: "Suresh", condition: "Dengue", imageName: "person.circle")
                            AttendedPatientCard(name: "Lily", condition: "X-ray", imageName: "person.circle")
                        }
                        .padding(.horizontal,27)
                    }
                    Spacer()
                }
                .navigationTitle("Hello, dr.\(apiService.doctorData?.firstName ?? "")")
                .padding(.top)
            }
        }
        .sheet(isPresented: $isPresentingContentView) {
            ContentView()
        }
        .onAppear {
            apiService.fetchDoctorData()
        }
    }
}

struct PatientCard: View {
    var name: String
    var condition: String
    var date: String
    var time: String
    var imageName: String
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(imageName)
                    .resizable()
                    .frame(width: 65, height: 70)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                VStack(alignment: .leading) {
                    Text(name)
                        .font(.headline)
                    Text(condition)
                        .font(.subheadline)
                }
                Spacer()
            }
            HStack {
                Image(systemName: "calendar")
                Text(date)
                Spacer()
                Image(systemName: "clock")
                Text(time)
            }
            .font(.caption)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2)
        .frame(width: 300)
    }
}

struct AttendedPatientCard: View {
    var name: String
    var condition: String
    var imageName: String
    
    var body: some View {
        VStack {
            Image(systemName: imageName)
                .resizable()
                .frame(width: 90, height: 70)
                .clipShape(Circle())
            Text(name)
                .font(.headline)
            Text(condition)
                .font(.caption)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2)
        .frame(width: 100)
    }
}



struct DoctorHomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        DoctorHomeView()
    }
}

