//
//  bookLabAppointmentsView.swift
//  Hospital-Management-System
//
//  Created by MACBOOK on 06/06/24.
//

import SwiftUI


struct bookLabAppointmentsView: View {
    @State private var selectedTest = "Blood Test"
    @State private var selectedType = "Blood Glucose Test"
    @State private var selectedDate = Date()
    @State private var selectedTimeSlot = "Morning"
    
    let timeSlots = ["Morning", "Afternoon", "Evening"]

    var testNames: [String] {
        return Array(LabTests.keys)
    }
    
    var types: [String] {
        return LabTests[selectedTest] ?? ["No types available"]
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment:.leading) {
                HStack {
                    Text("Test")
                    Spacer()
                    Picker("Test", selection: $selectedTest) {
                        ForEach(testNames, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .labelsHidden()
                }
                .padding()
                
                HStack {
                    Text("Type")
                    Spacer()
                    Picker("Type", selection: $selectedType) {
                        ForEach(types, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .labelsHidden()
                }
                .padding()
                
                DatePicker("Select Date", selection: $selectedDate,
                           
                           displayedComponents: .date)
                    .padding()
                
                HStack {
                    Text("Time Slot")
                    Spacer()
                    Picker("Time Slot", selection: $selectedTimeSlot) {
                        ForEach(timeSlots, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .labelsHidden()
                }
                .padding()

//                NavigationLink(destination: Text("Test booked!"), label: {
//                    Text("Book Test")
//                        .foregroundColor(.white)
//                        .padding()
//                        .frame(maxWidth:.infinity)
//                        .background(Color.blue)
//                        .cornerRadius(10)
//                })
//                .padding()
                
                Button(action: {
                    // Approve 
                    print("hello")
                    print(selectedDate)
                    let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "yyyy-MM-dd"
                            let formattedDate = dateFormatter.string(from: selectedDate)
                            
                            patientService.bookLabAppointment(testName: selectedType, timeSlot: selectedTimeSlot, date: formattedDate)
                        
                    
                       }) {
                    Text("Book appointment")
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(5)
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(15)
            .shadow(color: Color.gray.opacity(0.5), radius: 10, x: 0, y: 5)
            .navigationTitle("")
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    bookLabAppointmentsView()
}
