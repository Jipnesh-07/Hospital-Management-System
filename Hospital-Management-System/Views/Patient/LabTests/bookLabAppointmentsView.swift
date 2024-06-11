import SwiftUI

struct BookLabAppointmentsView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedTest = "Blood Test"
    @State private var selectedType = "Blood Glucose Test"
    @State private var selectedDate = Date()
    @State private var selectedTimeSlot = "Morning"
    @State private var showSuccessAlert = false
    
    let timeSlots = ["Morning", "Afternoon", "Evening"]
    
    var testNames: [String] {
        return Array(LabTests.keys)
    }
    
    var types: [String] {
        return LabTests[selectedTest] ?? ["No types available"]
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Lab Appointment")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                
                VStack(alignment: .leading, spacing: 20) {
                    
                    HStack(content: {
                        Text("Test Type:")
                        Spacer()
                        
                        Picker("Test", selection: $selectedTest) {
                            ForEach(testNames, id: \.self) {
                                Text($0)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        
                    })
                    
                    
                    
                    HStack(content: {
                        Text("Test Name:")
                        
                        Spacer()
                        
                        Picker("Type", selection: $selectedType) {
                            ForEach(types, id: \.self) {
                                Text($0)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        
                    })
                    
                    
                    
                   
                    
                    
                    
                    DatePicker("Select Date", selection: $selectedDate, displayedComponents: .date)
                    
                    
                    
                    HStack(content: {
                        Text("Slot:")
                        
                        Spacer()
                        
                        Picker("Time Slot", selection: $selectedTimeSlot) {
                            ForEach(timeSlots, id: \.self) {
                                Text($0)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        
                    })
                    
                    
                }
                .padding()
                
                Button(action: {
                    // Book Lab Appointment
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    let formattedDate = dateFormatter.string(from: selectedDate)
                    patientService.bookLabAppointment(testName: selectedType, timeSlot: selectedTimeSlot, date: formattedDate)
                    showSuccessAlert = true // Show success alert
                }) {
                    Text("Book Appointment")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding()
                .alert(isPresented: $showSuccessAlert) {
                    Alert(
                        title: Text("Appointment Booked Successfully ✅"),
                        message: Text("Your lab appointment has been booked."),
                        dismissButton: .default(Text("OK")) {
                            presentationMode.wrappedValue.dismiss()
                        }
                    )
                }
                
                Spacer()
            }
           
        }
    }
}

struct BookLabAppointmentsView_Previews: PreviewProvider {
    static var previews: some View {
        BookLabAppointmentsView()
    }
}
