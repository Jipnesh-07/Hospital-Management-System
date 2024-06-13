//
//  mainPatientBannerCardView.swift
//  Hospital-Management-System
//
//  Created by MACBOOK on 13/06/24.
//

import SwiftUI

struct mainPatientBannerCardView: View {
    var body: some View {
        VStack(alignment: .leading){
            
            VStack(alignment: .leading){
                Text("Medical insights")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)
                Text("& innovations")
                //                    .multilineTextAlignment(.leading)
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)
                
                Text("Our eploration the medical insights ")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                Text("and innovations is sure to inform")
                //                    .multilineTextAlignment(.leading)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
            }
            .padding()
            
            Spacer()
            VStack{
                HStack{
                    Spacer()
//                        .frame(width: -16)
                    Image(systemName: "face.smiling.inverse")
                        .resizable()
                        .frame(width: 45,height: 45)
                        .font(.largeTitle)
                        .foregroundColor(.white).opacity(0.5)
                    
                    Spacer()
                    Image(systemName: "stethoscope")
                        .resizable()
                        .frame(width: 40,height: 40)
                        .font(.largeTitle)
                        .foregroundColor(.white).opacity(0.5)
                        .rotationEffect(Angle(degrees:18))
                    
                    Spacer()
                    Image(systemName: "heart")
                        .resizable()
                        .frame(width: 39,height: 39)
                        .font(.largeTitle)
                        .foregroundColor(.white).opacity(0.5)
                    
                    Spacer()
                    Image(systemName: "ear.fill")
                        .resizable()
                        .frame(width: 40,height: 45)
                        .font(.largeTitle)
                        .foregroundColor(.white).opacity(0.5)
                        .rotationEffect(Angle(degrees:1))
                }
                .padding()
                
                HStack{
                    Spacer().frame(width: 30)
                    
                    Image(systemName: "testtube.2")
                        .resizable()
                        .frame(width: 40,height: 40)
                        .font(.largeTitle)
                        .foregroundColor(.white).opacity(0.5)
                        .rotationEffect(Angle(degrees: 320))
                    
                    
                    Spacer().frame(width: 30)
                    Spacer().frame(width: 30)
                    Image(systemName: "message.fill")
                        .resizable()
                        .frame(width: 45,height: 45)
                        .font(.largeTitle)
                        .foregroundColor(.white).opacity(0.5)
                    
                    Spacer().frame(width: 30)
                    Spacer().frame(width: 30)
                    Image(systemName: "phone")
                        .resizable()
                        .frame(width: 40,height: 40)
                        .font(.largeTitle)
                        .foregroundColor(.white).opacity(0.5)
                    
                    
                    
                }
                .padding()
            }
            
            
            Spacer().frame(height: 1)
            
            
        }
        .frame(maxWidth: .infinity)
        .frame(height: 400)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(Color(red: 97/255, green: 120/255, blue: 187/255)))
        .cornerRadius(20)
        .shadow(radius: 1)
        .padding(.leading, 16)
        .padding(.trailing, 16)
    }
}

#Preview {
    mainPatientBannerCardView()
}
