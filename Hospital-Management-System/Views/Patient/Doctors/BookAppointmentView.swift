//
//  BookAppointmentView.swift
//  Hospital-Management-System
//
//  Created by MACBOOK on 06/06/24.
//

import SwiftUI

struct BookAppointmentView: View {
    @State private var showTimePicker = false
    @State private var selectedTime = Date()
    @State private var selectedOption = ""

    let options = ["Morning Shift", "Afternoon Shift", "Evening Shift"]

    var body: some View {
        VStack {
            Spacer()
            CardView()
        }
    }
}

#Preview {
    BookAppointmentView()
}


struct CardView: View {
    @State private var textFieldText = ""
    @State private var selectedOption = ""
    @State private var selectDate = Date()
    
    let options = ["Morning Shift", "Afternoon Shift", "Evening Shift"]

    var body: some View {
        VStack{
            HStack{
                DatePicker("Date", selection: $selectDate, displayedComponents: [.date])
                
                

                
            }
            .padding()
            
            HStack{
                
                
            }
            .padding()
            
        }
    }
}
