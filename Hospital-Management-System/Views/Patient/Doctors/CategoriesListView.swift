//
//  CategoriesListView.swift
//  Hospital-Management-System
//
//  Created by MACBOOK on 05/06/24.
//

import SwiftUI

//import SwiftUI

struct CategoriesListView: View {
    @State private var searchTitle: String = ""
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false){
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
                    
                    Section{
                        NavigationLink(destination: DoctorsListView()){
                            VStack(spacing: 16) {
                                ForEach(categories1) { category in
                                    CategoryRow(category: category)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                    
                    Spacer()
                    
                }
            }
            .navigationTitle("Doctors")
            .searchable(text: $searchTitle)
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
                
    //            NavigationLink(destination: DoctorsListView()){
    //                Image(systemName: "chevron.right")
    //                    .foregroundColor(.gray)
    //            }
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

// Sample Data
let categories1 = [
    Category2(imageName: "heart", name: "Cardiologist", description: "Heart and Blood vessels"),
    Category2(imageName: "rash", name: "Dermatology", description: "Skin, hair, and nails."),
    Category2(imageName: "heel", name: "Anesthesiology", description: "Pain relief"),
    Category2(imageName: "stomach", name: "Gastroenterology", description: "Digestive system disorders"),
    Category2(imageName: "brain", name: "Neurology", description: "Brain and neurone"),
    Category2(imageName: "uterus", name: "Gynecology", description: "Female reproductive system"),
    Category2(imageName: "read", name: "Ophthalmology", description: "Eyes")
]


#Preview {
    CategoriesListView()
}
