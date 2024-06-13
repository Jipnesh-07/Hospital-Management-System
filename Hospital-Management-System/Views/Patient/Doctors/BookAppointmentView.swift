//
//  BookAppointmentView.swift
//  Hospital-Management-System
//
//  Created by MACBOOK on 06/06/24.
//

import SwiftUI

struct BookAppointmentView: View {
    var doctorId: String
    @State private var showBookingSheet = false

    var body: some View {
//        NavigationView {
            VStack {
                Spacer()
                // Automatically show the booking sheet on launch
                BookingSheetView(doctorId: doctorId)
                Spacer()
            }
            .navigationBarTitle("Cardiologist", displayMode: .inline)
//        }
    }
}


struct BookAppointmentView_Previews: PreviewProvider {
    static var previews: some View {
        BookAppointmentView(doctorId: "doctor123")
    }
}



struct BookingSheetView: View {
    var doctorId: String

    @Environment(\.presentationMode) var presentationMode
    @State private var selectedDate = Date()
    @State private var selectedSlot = "Morning"
    @State private var symptom = ""
    @State private var showAlert = false
    @State private var showSuccessAlert = false
    @State private var fieldErrorMessage = ""
    @State private var alertMessage = ""

    let slotOptions = ["Morning", "Afternoon", "Evening"]
    let currentDate = Date()

    var body: some View {
        VStack {
            Spacer()
            Form {
                Section(header: Text("Date*")) {
                    DatePicker("Select Date", selection: $selectedDate, in: currentDate..., displayedComponents: .date)
                }

                Section(header: Text("Slots*")) {
                    Picker("Select Slot", selection: $selectedSlot) {
                        ForEach(slotOptions, id: \.self) { slot in
                            Text(slot)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                }

                Section(header: Text("Symptom*")) {
                    TextField("Symptom", text: $symptom)
                        .onChange(of: symptom) { newValue in
                                                    if !newValue.isEmpty {
                                                        fieldErrorMessage = ""
                                                    }
                                                }
                                            if !fieldErrorMessage.isEmpty {
                                                Text(fieldErrorMessage)
                                                    .foregroundColor(.red)
                                                    .font(.caption)
                                            }
                }

                Button(action: {
                    // Validate symptom
                    guard !symptom.isEmpty else {
                                            fieldErrorMessage = "Please enter a symptom."
                                            return
                                        }

                                        // Clear the error message if the validation passes
                                        fieldErrorMessage = ""
                    
                    let dateFormatter = DateFormatter()
                                                   dateFormatter.dateFormat = "yyyy-MM-dd"
                    let formattedDate = dateFormatter.string(from: selectedDate)
                                        
                                        print(formattedDate)
                                        

                    // Perform booking if symptom is not empty
                    bookAppointment(formattedDate: formattedDate)
                }) {
                    Text("Book Appointment")
                        .foregroundColor(.white)
                        .padding()
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .background(Color(red: 97/255, green: 120/255, blue: 187/255))
                        .cornerRadius(10)
                    
                }
            }
        }
//        .background(Color(red: 243/255, green: 241/255, blue: 239/255))
        
       
          
         
            
            .alert(isPresented: $showSuccessAlert) {
                Alert(
                    title: Text("Success"),
                    message: Text(alertMessage),
                    dismissButton: .default(Text("OK")) {
                        presentationMode.wrappedValue.dismiss()
                    }
                )
        
        }
    }

    private func bookAppointment(formattedDate: String) {
        patientService.bookDocAppointment(
                                docId: doctorId, timeSlot: selectedSlot, date: formattedDate, symptom: symptom
                            )
        print("Booking appointment...")
        
        alertMessage = "Your appointment has been booked"
        showSuccessAlert = true
    }
    
    
}
