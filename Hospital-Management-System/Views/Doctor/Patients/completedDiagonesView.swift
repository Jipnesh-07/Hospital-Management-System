////
////  completedDiagonesView.swift
////  Hospital-Management-System
////
////  Created by Ravneet Singh on 12/06/24.
////
//
//import SwiftUI
//
//struct completedDiagonesView: View {
//    let patient: Patient
//
//    var body: some View {
//        VStack(spacing: 0) {
//            HStack {
//                Spacer()
//                Button("Done") {}
//                    .padding()
//                    .foregroundColor(.blue)
//                    .font(.system(size: 16, weight: .bold))
//            }
//            .background(Color(red: 241/255, green: 241/255, blue: 246/255))
//            
//            VStack(spacing: 10) {
//                Image("user1")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 75, height: 75)
//                    .clipShape(Circle())
//                    .overlay(
//                        Circle().stroke(Color.white, lineWidth: 2)
//                    )
//                    .padding(.top, -20)
//                
//                Form {
//                    Section {
//                        HStack {
//                            Text("First Name")
//                            Spacer()
//                            Text(patient.appointment.patient.firstName)
//                                .foregroundColor(.black)
//                        }
//                        .frame(height: 37)
//                        
//                        HStack {
//                            Text("Last Name")
//                            Spacer()
//                            Text(patient.appointment.patient.lastName)
//                                .foregroundColor(.black)
//                        }
//                        .frame(height: 37)
//                        
//                        HStack {
//                            Text("Sex")
//                            Spacer()
//                            Text(patient.appointment.patient.gender)
//                                .foregroundColor(.black)
//                        }
//                        .frame(height: 37)
//                        
//                        HStack {
//                            Text("Blood Group")
//                            Spacer()
//                            Text("A+") // Assuming Blood Group is A+; update logic as needed
//                                .foregroundColor(.black)
//                        }
//                        .frame(height: 37)
//                        
//                        HStack {
//                            Text("Date")
//                            Spacer()
//                            Text(patient.appointment.date)
//                                .foregroundColor(.black)
//                        }
//                        .frame(height: 37)
//                        
//                        HStack {
//                            Text("Time")
//                            Spacer()
//                            Text(patient.appointment.timeSlot)
//                                .foregroundColor(.black)
//                        }
//                        .frame(height: 37)
//                        
//                        HStack {
//                            Text("Symptoms")
//                            Spacer()
//                            Text(patient.appointment.symptom)
//                                .foregroundColor(.black)
//                        }
//                        .frame(height: 37)
//                    }
//                    
//                    Section(header: Text("Prescribe")
//                        .font(.title3)
//                        .foregroundColor(.black)
//                        .textCase(.none)
//                        .frame(maxWidth: .infinity, alignment: .leading)) {
//                            Text(patient.appointment.prescription)
//                                .frame(height: 100)
//                                .multilineTextAlignment(.leading)
//                                .lineLimit(4)
//                        }
//                    
//                    Section(header: Text("Lab tests")
//                        .font(.title3)
//                        .foregroundColor(.black)
//                        .textCase(.none)
//                        .frame(maxWidth: .infinity, alignment: .leading)) {
//                            ForEach(patient.appointment.tests, id: \.self) { test in
//                                Text(test)
//                                    .frame(height: 35)
//                                    .multilineTextAlignment(.leading)
//                                    .lineLimit(4)
//                            }
//                        }
//                }
//                .listStyle(InsetGroupedListStyle())
//            }
//            .background(Color(red: 241/255, green: 241/255, blue: 246/255))
//        }
//    }
//}
//
////#Preview {
////    completedDiagonesView(patient: <#Patient#>)
////}
