//
//  PatientHomeView.swift
//  Hospital-Management-System
//
//  Created by MACBOOK on 05/06/24.
//


import SwiftUI

let dateFormatter2: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd MMM, yy"
    return formatter
}()

struct PatientHomeView: View {
    @StateObject private var patientService = PatientService()
    @State private var showHealthDetails = false
    let bloodGroup: String = UserDefaults.standard.string(forKey: "bloodGroup") ?? ""
    let height: String = UserDefaults.standard.string(forKey: "height") ?? ""
    let weight: String = UserDefaults.standard.string(forKey: "weight") ?? ""
    
    var bmi: Double {
        let heightInMeters = (Double(height) ?? 0) / 100
        let weightInKg = Double(weight) ?? 0
        if heightInMeters > 0 {
            return weightInKg / (heightInMeters * heightInMeters)
        } else {
            return 0.0
        }
    }
    
    @State var searchText: String = ""
    var body: some View {
        NavigationView{
            ScrollView(showsIndicators: false){
                VStack{
                    
                    mainPatientBannerCardView()
                    HStack{
                        Text("Appointments")
                            .font(.title2)
                            .fontWeight(.semibold)
                        Spacer()
                        NavigationLink(destination: PatientAppointmentVeiw()){
                            Text("View all")
                                .fontWeight(.medium)
                                .foregroundColor(.blue)
                        }
                    }
                    .padding(.horizontal)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(patientService.appointments.prefix(5)) { appointment in
                                AppointmentCardView(appointment: appointment)
                                    .transition(.slide)
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    HStack{
                        Text("Health Detials")
                            .font(.title2)
                            .fontWeight(.semibold)
                        Spacer()
                        NavigationLink(destination: HealthDetailsView()){
                            Text("View all")
                                .fontWeight(.medium)
                                .foregroundColor(.blue)
                        }
                    }
                    .padding(.horizontal)
                    
                    VStack{
                        HStack(spacing: 1){
                            VStack{
                                HStack{
                                    Image(systemName: "drop")
                                        .font(.title)
                                        .foregroundColor(.red)
                                        .padding(10)
                                        .padding(.top,-8)
                                    Spacer()
                                    Text("\(bloodGroup)")
                                        .font(.title3)
                                        .fontWeight(.medium)
                                        .padding(10)
                                        .padding(.top,-8)
                                    
                                }
                                .frame(width: 160)
                                .padding(.vertical)
                                
                                Spacer()
                                Text("Blood Group")
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
                                    Image(systemName: "ruler")
                                        .font(.title)
                                        .foregroundColor(.purple)
                                        .padding(10)
                                        .padding(.top,-8)
                                        .rotationEffect(Angle(degrees: 90))
                                    Spacer()
                                    Text("\(height)")
                                        .font(.title3)
                                        .fontWeight(.medium)
                                        .padding(10)
                                        .padding(.top,-8)
                                    
                                }
                                .frame(width: 160)
                                .padding(.vertical)
                                
                                Spacer()
                                Text("Height")
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
                        
                        HStack(spacing: 1){
                            VStack{
                                HStack{
                                    Image(systemName: "scalemass")
                                        .font(.title)
                                        .foregroundColor(.orange)
                                        .padding(10)
                                        .padding(.top,-8)
                                    Spacer()
                                    Text("\(weight)")
                                        .font(.title3)
                                        .fontWeight(.medium)
                                        .padding(10)
                                        .padding(.top,-8)
                                    
                                }
                                .frame(width: 160)
                                .padding(.vertical)
                                
                                Spacer()
                                Text("Weight")
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
                                    Text("BMI")
                                        .font(.title2)
                                        .foregroundColor(.blue)
                                        .padding(10)
                                        .padding(.top,-8)
                                    Spacer()
                                    Text(String(format: "%.1f", bmi))
                                        .font(.title3)
                                        .fontWeight(.medium)
                                        .padding(10)
                                        .padding(.top,-8)
                                    
                                }
                                .frame(width: 160)
                                .padding(.vertical)
                                
                                Spacer()
                                Text("BMI")
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
                }
            }.navigationTitle("Home")
                .navigationBarItems(trailing:
                                        NavigationLink(destination: EmergencyBookingView()) {
                                            Image(systemName: "light.beacon.max")
                                                .font(.title3)
                                                .foregroundColor(.red)
                                                
                                        }
                                    )
                .background(Color(red: 243/255, green: 241/255, blue: 239/255))
        }
        .searchable(text: $searchText)
        .onAppear {
            // Fetch data when the view appears
            patientService.getAppointments()
            //patientService.getLabAppointments()
        }
    }
    
    
}

struct AppointmentCardView: View {
    let appointment: PatientAppointment
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                HStack{
          
                    
                    VStack{
                        Image("user2") // Replace with your image
                            .resizable()
                            .frame(width: 90, height: 90)
                        //                                .padding(.top)
                            .clipShape(RoundedRectangle(cornerRadius: 9))
                    }
                    .padding(.top)
                    
                    Spacer()
                    Spacer()
                    Spacer().frame(width: 40)
                    VStack(alignment: .trailing){
                        Text("\(appointment.doctor.firstName) \(appointment.doctor.lastName)")
                            .font(.title3)
                            .fontWeight(.medium)
                        
                        Text("\(appointment.doctor.specialization)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        
                    }
                    
                    
                }
                .padding(.top,-9)
                
                Spacer().frame(height: 1)
                Spacer()
                Divider()
                HStack{
                    
                    HStack{
                        
                        
                        Text("\(appointment.timeSlot)")
                            .font(.system(size: 15))
                            .fontWeight(.bold)
                            .foregroundColor(Color(.darkGray))
                            .padding(9)
//                            .background(RoundedRectangle(cornerRadius: 12).stroke(Color.gray, lineWidth: 1))
                        Spacer()
                        Text(dateFormatter2.string(from: appointment.date))
                            .font(.system(size: 15))
                            .fontWeight(.bold)
                            .foregroundColor(Color(.darkGray))
                            .padding(9)
                    }
                
                    Spacer()
                    
//                    Text("↓")
//                        .font(.system(size: 20))
//                        .frame(width: 24)
//                        .padding(12)
//                        .rotationEffect(Angle(degrees: 270))
//                        .foregroundColor(.white)
//                        .background(RoundedRectangle(cornerRadius: 10).stroke(Color.white, lineWidth: 1).fill(Color(red: 97/255, green: 120/255, blue: 187/255)))
                    
                }
            }
            
            Spacer()
            
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 16).fill(Color.white))
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
        .padding()
    }
}



#Preview {
    PatientHomeView()
}
