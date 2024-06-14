


import SwiftUI


struct AdminHomeView: View {
@State private var searchText = ""
@State private var showModal = false

var body: some View {
    NavigationView {
        ScrollView {
            VStack(spacing: 20) {
                // Search Bar
                SearchBarle(text: $searchText)
                    .padding([.leading, .trailing, .top])
                
                // New Doctors Section
//                HStack {
//                    Text("New Doctors")
//                        .font(.headline)
//                    Spacer()
//                    NavigationLink(destination: DoctorApprovalList()) {
//                        Text("View All")
//                            .foregroundColor(.blue)
//                    }
//                }
//                .padding(.horizontal)
                
//                DoctorCardView()
                VStack{
                                                       HStack(spacing: 1){
                                                           VStack{
                                                               HStack{
                                                                   Image(systemName: "stethoscope")
                                                                       .font(.title)
                                                                       .foregroundColor(.blue)
                                                                       .padding(10)
                                                                       .padding(.top,-8)
                                                                   Spacer()
               //                                                    Text("\(bloodGroup)")
                                                                   Text("50")
                                                                       .font(.title3)
                                                                       .fontWeight(.medium)
                                                                       .padding(10)
                                                                       .padding(.top,-8)
                                                                   
                                                               }
                                                               .frame(width: 160)
                                                               .padding(.vertical)
                                                               
                                                               Spacer()
                                                               Text("Total Doctors")
                                                                   .font(.title3)
                                                                   .fontWeight(.semibold)
                                                                   .padding(8)
                                                           }
                                                           .background(
                                                               RoundedRectangle(cornerRadius: 10)
                                                                   .fill(Color.white)
                                                                   .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                                                           )
                                                           .padding(.horizontal)
                                                           
                                                           VStack{
                                                               HStack{
                                                                   Image(systemName: "person")
                                                                       .font(.title)
                                                                       .foregroundColor(.purple)
                                                                       .padding(10)
                                                                       .padding(.top,-8)
                                                                       
                                                                   Spacer()
               //                                                    Text("\(height)")
                                                                   Text("120")
                                                                       .font(.title3)
                                                                       .fontWeight(.medium)
                                                                       .padding(10)
                                                                       .padding(.top,-8)
                                                                   
                                                               }
                                                               .frame(width: 160)
                                                               .padding(.vertical)
                                                               
                                                               Spacer()
                                                               Text("Total Patients")
                                                                   .font(.title3)
                                                                   .fontWeight(.semibold)
                                                                   .padding(8)
                                                           }
                                                           .background(
                                                               RoundedRectangle(cornerRadius: 10)
                                                                   .fill(Color.white)
                                                                   .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                                                           )
                                                           .padding(.horizontal)
                                                           
                                                           
                                                       }
                                                       
                               
                                                   }
                
                // Total Patients Graph Section
                SectionView(title: "Total Doctors", destination: DoctorCategoryListView()) {
                    BarChartView(data: [13, 9, 11, 15, 10, 17, 14, 12], title: "Doctors")
                }
            }
            .navigationTitle("Admin")
            .navigationBarItems(trailing:
                                    NavigationLink(destination: EmergencyRequestsView()) {
                                        Image(systemName: "light.beacon.max")
                                            .font(.title3)
                                            .foregroundColor(.red)
                                            
                                    }
                                )
        }
//        .navigationBarItems(trailing: Button(action: {
//            showModal = true
//        }) {
//            Image(systemName: "light.beacon.max.fill")
//                .resizable()
//                .frame(width: 30, height: 30)
//                .foregroundColor(.gray)
//                .padding(.top, 80)
//        })
        .sheet(isPresented: $showModal) {
            EmergencyFormView(showModal: $showModal)
        }
    }
}
}

// SearchBar View
struct SearchBarle: View {
    @Binding var text: String

    var body: some View {
        HStack {
            TextField("Search", text: $text)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)

                        if !text.isEmpty {
                            Button(action: {
                                self.text = ""
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                )
        }
        .padding(.horizontal, 10)
    }
}

struct DoctorCardView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                VStack(alignment: .leading) {
                    Text("Dr Shreya Sharma")
                        .font(.headline)
                    Text("Dentist Specialist")
                        .font(.subheadline)
                }
                Spacer()
                InfoButton()
            }
            HStack {
                Button(action: {
                    // Approve action
                }) {
                    Text("Approve")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                Button(action: {
                    // Reject action
                }) {
                    Text("Reject")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .padding(.horizontal)
    }
}

struct InfoButton: View {
    var body: some View {
        Button(action: {
            // Info action
        }) {
            Image(systemName: "info.circle")
                .foregroundColor(.blue)
        }
    }
}

struct BarChartView: View {
    let data: [CGFloat]
    let title: String

    var body: some View {
        VStack {
            HStack(alignment: .bottom) {
                ForEach(data, id: \.self) { value in
                    VStack {
                        Spacer()
                        Rectangle()
                            .fill(Color.blue)
                            .frame(height: value * 10)
                        Text("\(Int(value))")
                            .font(.caption)
                            .rotationEffect(.degrees(-45))
                            .offset(y: 10)
                    }
                }
            }
            .frame(height: 200)
            .padding(.horizontal, 10)
        }
    }
}

struct SectionView<Content: View>: View {
    let title: String
    let destination: AnyView
    let content: () -> Content
    
    init<Destination: View>(title: String, destination: Destination, @ViewBuilder content: @escaping () -> Content) {
        self.title = title
        self.destination = AnyView(destination)
        self.content = content
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(title)
                    .font(.headline)
                    .padding([.leading, .top])
                Spacer()
                NavigationLink(destination: destination) {
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                        .padding()
                       
                }
            }
            
            Text("\(title) averaged more over the past 16 days")
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding([.leading, .trailing, .bottom])
            
            content()
                .frame(height: 250)
                .padding([.leading, .trailing])
        }
        .background(Color(.systemGray6)) // Set background color to gray
        .cornerRadius(10) // Optionally, add corner radius to match DoctorCardView
        .padding(.horizontal)
    }
}
// EmergencyFormView for Modal
struct EmergencyFormView: View {
    @Binding var showModal: Bool
    @State private var selectedDoctor = ""
    @State private var patientFees = ""

    let doctors = ["Dr. Shreya Sharma", "Dr. John Doe", "Dr. Alice Smith"]

    var body: some View {
        NavigationView {
            Form {
                Picker("Select Doctor", selection: $selectedDoctor) {
                    ForEach(doctors, id: \.self) { doctor in
                        Text(doctor)
                    }
                }

                TextField("Patient Fees", text: $patientFees)
                    .keyboardType(.decimalPad)
            }
            .navigationBarTitle("Emergency Form", displayMode: .inline)
            .navigationBarItems(
                leading: Button("Cancel") {
                    showModal = false
                },
                trailing: Button("Done") {
                    // Handle the done action
                    showModal = false
                }
            )
        }
    }
}


#Preview {
    AdminHomeView()
}
