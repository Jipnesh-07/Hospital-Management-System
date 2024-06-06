//
//  Patient.swift
//  Hospital-Management-System
//
//  Created by MACBOOK on 04/06/24.
//

import Foundation
import SwiftUI
struct Patient: Codable{
    
    let user: User
    let bloodGroup: String
    let weight: Int
    let height: Int
    let symptom: String
    let address: String
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.user = try container.decode(User.self, forKey: .user)
        self.bloodGroup = try container.decode(String.self, forKey: .bloodGroup)
        self.weight = try container.decode(Int.self, forKey: .weight)
        self.height = try container.decode(Int.self, forKey: .height)
        self.symptom = try container.decode(String.self, forKey: .symptom)
        self.address = try container.decode(String.self, forKey: .address)
    }
    
    
    
}

struct Category: Identifiable{
    let id: UUID
    let name: String
    let imageName: String
}

let categories = [
    Category(id: UUID(), name: "Cardiologist", imageName: "heart.fill"),
    Category(id: UUID(), name: "Dermatologist", imageName: "face.smiling.fill"),
    Category(id: UUID(), name: "Neurologist", imageName: "brain.head.profile"),
    Category(id: UUID(), name: "Pediatrician", imageName: "person.3.fill"),
    Category(id: UUID(), name: "Orthopedic Surgeon", imageName: "figure.walk"),
    Category(id: UUID(), name: "Psychiatrist", imageName: "person.crop.circle.badge.exclamationmark"),
    Category(id: UUID(), name: "Ophthalmologist", imageName: "eye.fill"),
    Category(id: UUID(), name: "Radiologist", imageName: "waveform.path.ecg"),
    Category(id: UUID(), name: "General Practitioner", imageName: "stethoscope"),
    Category(id: UUID(), name: "Endocrinologist", imageName: "drop.fill"),
    Category(id: UUID(), name: "Gastroenterologist", imageName: "bandage.fill"),
    Category(id: UUID(), name: "Oncologist", imageName: "cross.fill"),
    Category(id: UUID(), name: "Pulmonologist", imageName: "lungs.fill")
]




struct DoctorFormView: View {
    @State private var name: String = ""
    @State private var selectedCategoryID: UUID? = nil
    
    var body: some View {
        Form {
            TextField("Name", text: $name)
            
            Picker("Category", selection: $selectedCategoryID) {
                ForEach(categories) { category in
                    Text(category.name).tag(category.id as UUID?)
                }
            }
            
            Button(action: {
                
            }) {
                Text("Save Doctor")
            }
        }
    }
    //
    //    func saveDoctor() {
    //        // Handle saving the doctor data
    //        guard let categoryID = selectedCategoryID else { return }
    //        let newDoctor = Doctor(id: UUID(), name: name, categoryID: categoryID)
    //        // Save the doctor (e.g., add to an array, save to a database, etc.)
    //        // For this example, let's just print the new doctor
    //        print(newDoctor)
    //    }
    //}
    //struct ContentView: View {
    //    var body: some View {
    //        NavigationView {
    //            List {
    //                ForEach(categories) { category in
    //                    Section(header: Text(category.name)) {
    //                        ForEach(doctors.filter { $0.categoryID == category.id }) { doctor in
    //                            Text(doctor.name)
    //                        }
    //                    }
    //                }
    //            }
    //            .navigationTitle("Doctors")
    //        }
    //    }
    //}
}
