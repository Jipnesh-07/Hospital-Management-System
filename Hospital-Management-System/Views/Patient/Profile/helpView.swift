//
//  helpView.swift
//  Hospital-Management-System
//
//  Created by MACBOOK on 13/06/24.
//

import SwiftUI

struct helpView: View {
    var body: some View {
        
        VStack(alignment: .leading, spacing: 20) {
            
            Text("Here you can find answers to frequently asked questions and contact support if you need further assistance.")
                .font(.body)
                .padding(.bottom, 20)
            
            Text("Frequently Asked Questions")
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.bottom, 10)
            
            List {
                FAQItem(question: "How to update my profile?", answer: "Go to the profile section in the app and click on the edit button to update your profile information.")
                FAQItem(question: "How to view my appointments?", answer: "Go to the appointments section in the app to view all your upcoming and past appointments.")
                FAQItem(question: "How to contact a patient?", answer: "You can contact a patient directly through the messaging feature in the app.")
            }
            .listStyle(PlainListStyle())
            
            Spacer()
            
        }
        .padding(.horizontal)
        .navigationTitle("Help Center")
        
    }
}

#Preview {
    helpView()
}


struct FAQItem: View {
    var question: String
    var answer: String
    
    @State private var isExpanded: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Text(question)
                    .fontWeight(.semibold)
                Spacer()
                Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
            }
            .contentShape(Rectangle())
            .onTapGesture {
                withAnimation {
                    isExpanded.toggle()
                }
            }
            
            if isExpanded {
                Text(answer)
                    .font(.body)
                    .padding(.top, 5)
            }
        }
        .padding(.vertical, 10)
    }
}

#Preview {
    helpView()
}
