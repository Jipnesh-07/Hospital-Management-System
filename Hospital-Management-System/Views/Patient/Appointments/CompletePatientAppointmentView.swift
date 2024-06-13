//
//  CompletedPatientAppointmentView.swift
//  Hospital-Management-System
//
//  Created by Ravneet Singh on 13/06/24.
//

import SwiftUI

struct CompletePatientAppointmentView: View {
    let appointment: PatientAppointment
    
    var body: some View {
        VStack(spacing: 0) {
            //            HStack {
            //                Spacer()
            //                Button("Done") {}
            //                    .padding()
            //                    .foregroundColor(.blue)
            //                    .font(.system(size: 16, weight: .bold))
            //            }
            //            .background(Color(red: 241/255, green: 241/255, blue: 246/255))
            
            VStack(spacing: 10) {
                //                Image("user1") // Placeholder image, replace with actual patient image if available
                //                    .resizable()
                //                    .scaledToFit()
                //                    .frame(width: 75, height: 75)
                //                    .clipShape(Circle())
                //                    .overlay(
                //                        Circle().stroke(Color.white, lineWidth: 2)
                //                    )
                //                    .padding(.top, -20)
                
                Form {
                    Image("user1") // Placeholder image, replace with actual patient image if available
                        .resizable()
                        .scaledToFit()
                        .frame(width: 75, height: 75)
                        .clipShape(Circle())
                        .overlay(
                            Circle().stroke(Color.white, lineWidth: 2)
                        )
                        .padding(.top, -20)
                    
                    Section {
                        HStack {
                            Text("Status")
                            Spacer()
                            Text(appointment.status)
                                .foregroundColor(.black)
                        }
                        .frame(height: 37)
                        
                        //                        HStack {
                        //                            Text("Last Name")
                        //                            Spacer()
                        //                            Text(appointment.patient.lastName)
                        //                                .foregroundColor(.black)
                        //                        }
                        //                        .frame(height: 37)
                        
                        
                        
                        
                        HStack {
                            Text("Date")
                            Spacer()
                            Text(dateFormatter.string(from: appointment.date))
                                .foregroundColor(.black)
                        }
                        .frame(height: 37)
                        
                        HStack {
                            Text("Slot")
                            Spacer()
                            Text(appointment.timeSlot.rawValue)
                                .foregroundColor(.black)
                        }
                        .frame(height: 37)
                        
                        HStack {
                            Text("Symptoms")
                            Spacer()
                            Text(appointment.symptom)
                                .foregroundColor(.black)
                        }
                        .frame(height: 37)
                    }
                    
                    Section(header: Text("Prescription")
                        .font(.title3)
                        .foregroundColor(.black)
                        .textCase(.none)
                        .frame(maxWidth: .infinity, alignment: .leading)) {
                            Text(appointment.prescription ?? "")
                                .frame(height: 100)
                                .multilineTextAlignment(.leading)
                                .lineLimit(4)
                        }
                    
                    Section(header: Text("Lab tests")
                        .font(.title3)
                        .foregroundColor(.black)
                        .textCase(.none)
                        .frame(maxWidth: .infinity, alignment: .leading)) {
                            ForEach(appointment.tests ?? [], id: \.self) { test in
                                Text(test.testName)
                                    .frame(height: 35)
                                    .multilineTextAlignment(.leading)
                                    .lineLimit(4)
                            }
                        }
                }
                .listStyle(InsetGroupedListStyle())
            }
            .background(Color(red: 241/255, green: 241/255, blue: 246/255))
        }
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }
}
