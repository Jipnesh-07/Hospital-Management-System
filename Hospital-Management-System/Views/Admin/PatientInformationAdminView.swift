import SwiftUI

struct PatientInformationAdminView: View {
    var patient: PatientForAdmin

    var body: some View {
        VStack {
            Text("Personal information")
                .font(.headline)
                .padding(.top)
            
            HStack {
                Text("Name:")
                Spacer()
                Text(patient.firstName + " " + patient.lastName)
            }
            HStack {
                Text("Email:")
                Spacer()
                Text(patient.email)
            }
            HStack {
                Text("Gender:")
                Spacer()
                Text(patient.gender)
            }
            HStack {
                Text("Age:")
                Spacer()
                Text("\(patient.age)")
            }
            HStack {
                Text("Phone Number:")
                Spacer()
                Text("\(patient.phoneNumber)")
            }
            HStack {
                Text("Blood Group:")
                Spacer()
                Text("\(patient.bloodGroup)")
            }
            
            HStack {
                Text("Height:")
                Spacer()
                Text("\(patient.height)")
            }
            HStack {
                Text("Weight:")
                Spacer()
                Text("\(patient.weight)")
            }
            
            
            Spacer()
        }
        .padding()
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
    }
}
