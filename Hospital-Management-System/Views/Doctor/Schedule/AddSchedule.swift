//
//  addSchedule.swift
//  Hospital-Management-System
//
//  Created by Ravneet Singh on 12/06/24.
//

import SwiftUI

struct AddSchedule: View {
    @State private var selectedDate = Date()
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var showSuccessAlert = false
    @State private var isEditMode = false
    @State private var isLoading = true // Add loading state
    @State private var refresh = false // Add a state variable to control refresh

    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var doctorService = DoctorService()

    @State private var startTime1 = Date()
    @State private var endTime1 = Date()
    @State private var startTime2 = Date()
    @State private var endTime2 = Date()
    @State private var startTime3 = Date()
    @State private var endTime3 = Date()

    var body: some View {
//        NavigationView {
            VStack {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        
                } else if let doctor = doctorService.doctor, let schedule = doctor.schedule?.first {
                    Form {
                        SlotSection(slot: "Morning", startTime: $startTime1, endTime: $endTime1, isEditMode: $isEditMode)
                        SlotSection(slot: "Afternoon", startTime: $startTime2, endTime: $endTime2, isEditMode: $isEditMode)
                        SlotSection(slot: "Evening", startTime: $startTime3, endTime: $endTime3, isEditMode: $isEditMode)
                    }
                    .onAppear {
                        initializeTimes(from: schedule)
                    }
                } else {
                    Text("No Slots Avialable")
                }
            }
            //.navigationBarBackButtonHidden(true)
            .navigationBarTitle("Schedule", displayMode: .inline)
            .navigationBarItems(
                //leading: cancelButton,
                
                trailing: editButton)
            

            .onAppear {
                doctorService.fetchDoctorData { success in
                    isLoading = false
                    if !success {
                        alertMessage = "Failed to fetch doctor data."
                        showAlert = true
                    }
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
            .alert(isPresented: $showSuccessAlert) {
                Alert(title: Text("Success"), message: Text("Schedule added successfully."), dismissButton: .default(Text("OK")) {
                    self.presentationMode.wrappedValue.dismiss()
                })
            }
            .id(refresh)
//        }
         // Use the refresh state to force view reload
    }

//    private var cancelButton: some View {
//        Button(action: {
//            if isEditMode {
//                isEditMode = false // Switch back to display mode
//                refresh.toggle() // Toggle refresh to force view reload
//            } else {
//                self.presentationMode.wrappedValue.dismiss()
//            }
//        }) {
//            Text(isEditMode ? "Cancel" : "Back")
//        }
//    }

    private var editButton: some View {
        Button(action: {
            if isEditMode {
                saveSchedule()
            } else {
                isEditMode = true // Enter edit mode
            }
        }) {
            Text(isEditMode ? "Save" : "Edit")
        }
    }

    private func saveSchedule() {
        let slots = [
            ScheduleSlot(timeSlot: "Morning", startTime: formattedTime(date: startTime1), endTime: formattedTime(date: endTime1)),
            ScheduleSlot(timeSlot: "Afternoon", startTime: formattedTime(date: startTime2), endTime: formattedTime(date: endTime2)),
            ScheduleSlot(timeSlot: "Evening", startTime: formattedTime(date: startTime3), endTime: formattedTime(date: endTime3))
        ]

        let newSchedule = Schedule(date: formattedDate(date: selectedDate), slots: slots)
        doctorService.addSchedule(schedule: newSchedule) { success in
            if success {
                showSuccessAlert = true
                isEditMode = false // Switch back to display mode after saving
            } else {
                alertMessage = "Failed to add schedule."
                showAlert = true
            }
        }
    }

    private func initializeTimes(from schedule: Schedule) {
        if let morningSlot = schedule.slots.first(where: { $0.timeSlot == "Morning" }) {
            startTime1 = dateFormatter.date(from: morningSlot.startTime) ?? Date()
            endTime1 = dateFormatter.date(from: morningSlot.endTime) ?? Date()
        }
        if let afternoonSlot = schedule.slots.first(where: { $0.timeSlot == "Afternoon" }) {
            startTime2 = dateFormatter.date(from: afternoonSlot.startTime) ?? Date()
            endTime2 = dateFormatter.date(from: afternoonSlot.endTime) ?? Date()
        }
        if let eveningSlot = schedule.slots.first(where: { $0.timeSlot == "Evening" }) {
            startTime3 = dateFormatter.date(from: eveningSlot.startTime) ?? Date()
            endTime3 = dateFormatter.date(from: eveningSlot.endTime) ?? Date()
        }
    }

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }

    private func formattedTime(date: Date) -> String {
        return dateFormatter.string(from: date)
    }

    private func formattedDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
}

struct SlotSection: View {
    let slot: String
    @Binding var startTime: Date
    @Binding var endTime: Date
    @Binding var isEditMode: Bool

    var body: some View {
        Section(header: Text("")
            .font(.title3)
            .fontWeight(.semibold)
            .foregroundColor(.black)
            .multilineTextAlignment(.leading)) {
                
            Text("Slot: \(slot)")
                .font(.subheadline)
                .foregroundColor(.black).bold()
            
            if isEditMode {
                DatePicker("Start Time", selection: $startTime, displayedComponents: .hourAndMinute)
                    .environment(\.locale, Locale(identifier: "en_GB"))
                DatePicker("End Time", selection: $endTime, in: startTime...Date().addingTimeInterval(24 * 60 * 60), displayedComponents: .hourAndMinute)
                    .environment(\.locale, Locale(identifier: "en_GB"))
            } else {
                HStack {
                    Text("Start Time")
                    Spacer()
                    Text(formattedTime(date: startTime))
                        .foregroundColor(.gray)
                }
                HStack {
                    Text("End Time")
                    Spacer()
                    Text(formattedTime(date: endTime))
                        .foregroundColor(.gray)
                }
            }
        }
    }

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }

    private func formattedTime(date: Date) -> String {
        return dateFormatter.string(from: date)
    }
}

struct AddSchedule_Previews: PreviewProvider {
    static var previews: some View {
        AddSchedule()
    }
}
