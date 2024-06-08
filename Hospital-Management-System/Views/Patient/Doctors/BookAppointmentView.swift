//
//  BookAppointmentView.swift
//  Hospital-Management-System
//
//  Created by MACBOOK on 06/06/24.
//

import SwiftUI

struct BookAppointmentView: View {
    @State private var showBookingSheet = false

    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                // Automatically show the booking sheet on launch
                BookingSheetView()
                Spacer()
            }
            .navigationBarTitle("Cardiologist", displayMode: .inline)
        }
    }
}

#Preview {
    BookAppointmentView()
}



struct BookingSheetView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedDate = Date()
    @State private var startTime = Date()
    @State private var endTime = Date()
    @State private var selectedSlot = "Morning"
    
    let slotOptions = ["Morning", "Afternoon", "Evening"]

    var body: some View {
        VStack {
            
            Form {
                Section(header: Text("Date")) {
                    DatePicker("Select Date", selection: $selectedDate, displayedComponents: .date)
                }

                Section(header: Text("Slots")) {
                    Picker("Select Slot", selection: $selectedSlot) {
                        ForEach(slotOptions, id: \.self) { slot in
                            Text(slot)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    
                    DatePicker("Start Time", selection: $startTime, displayedComponents: .hourAndMinute)
                    DatePicker("End Time", selection: $endTime, displayedComponents: .hourAndMinute)
                }
            }
        }
    }
}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
