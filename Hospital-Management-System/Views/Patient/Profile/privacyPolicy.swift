//
//  privacyPolicy.swift
//  Hospital-Management-System
//
//  Created by MACBOOK on 13/06/24.
//

import SwiftUI

struct privacyPolicy: View {
    @State private var showInformationUse = false
    @State private var showInformationSharing = false
    @State private var showYourChoices = false
    @State private var showAlert = false
    
    var body: some View {
//        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
//                    Text("Privacy Policy")
//                        .font(.largeTitle)
//                        .fontWeight(.bold)
//                        .padding(.top, 20)
                    
                    Text("Your privacy is important to us. This privacy policy explains how we collect, use, and protect your information.")
                        .font(.body)
                        .padding(.bottom, 20)
                  
                    SectionViewPrivacy(
                        title: "Information Use",
                        content: "We use the information we collect to provide, maintain, and improve our services. This includes personalizing your experience, communicating with you, and ensuring the security of our services.",
                        isExpanded: $showInformationUse
                    )
                    
                    SectionViewPrivacy(
                        title: "Information Sharing",
                        content: "We do not share your personal information with third parties except as necessary to provide our services, comply with the law, or protect our rights.",
                        isExpanded: $showInformationSharing
                    )
                    
                    SectionViewPrivacy(
                        title: "Your Choices",
                        content: "You have choices regarding the information we collect and how it is used. You can update your information, opt out of certain uses, and contact us with any questions.",
                        isExpanded: $showYourChoices
                    )
                    
                    Spacer()
                    
//                    Button(action: {
//                        showAlert = true
//                    }) {
//                        Text("Accept Policy")
//                            .fontWeight(.semibold)
//                            .foregroundColor(.white)
//                            .padding()
//                            .frame(maxWidth: .infinity)
//                            .background(Color.blue)
//                            .cornerRadius(10)
//                    }
                    .padding(.bottom, 20)
                    .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text("Policy Accepted"),
                            message: Text("You have accepted the privacy policy."),
                            dismissButton: .default(Text("OK"))
                        )
                    }
                }
                .padding(.horizontal)
            }
            .navigationTitle("Privacy Policy")
//        }
    }
}

#Preview {
    privacyPolicy()
}


struct SectionViewPrivacy: View {
    var title: String
    var content: String
    @Binding var isExpanded: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Button(action: {
                withAnimation {
                    isExpanded.toggle()
                }
            }) {
                HStack {
                    Text(title)
                        .font(.title3)
                        .fontWeight(.semibold)
                    Spacer()
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .foregroundColor(.blue)
                }
                .padding(.vertical, 10)
            }
            if isExpanded {
                Text(content)
                    .font(.body)
                    .padding(.top, 5)
                    .transition(.opacity)
            }
        }
        .padding(.vertical, 10)
    }
}

#Preview {
    privacyPolicy()
}

