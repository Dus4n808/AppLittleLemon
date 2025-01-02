//
//  UserProfile.swift
//  Restaurant
//
//  Created by Dusan Fama on 27.12.2024.
//

import SwiftUI

struct UserProfile: View {
    @EnvironmentObject private var userData: UserData
    var body: some View {
        VStack (spacing: 20){
            Text("Information Personelle")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color("CustomGreen"))
                .padding(.top)
            Image("Profile")
                .resizable()
                .scaledToFill()
                .frame(width: 120, height: 120)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(Color("CustomGreen"), lineWidth: 3)
                )
                .shadow(radius: 5)
            VStack(alignment: .leading, spacing: 10) {
                HStack{
                    Text("Prénom :")
                        .font(.headline)
                        .foregroundStyle(Color("CustomGreen"))
                    
                    Spacer()
                    Text(userData.firstName)
                        .font(.headline)
                        .foregroundStyle(Color("CustomGreen"))
                }
                .padding()
                .background(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color("CustomGreen"), lineWidth: 2)
                )
                
                
                HStack{
                    Text("Nom :")
                        .font(.headline)
                        .foregroundStyle(Color("CustomGreen"))
                    
                    Spacer()
                    Text(userData.lastName)
                        .font(.headline)
                        .foregroundStyle(Color("CustomGreen"))
                }
                .padding()
                .background(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color("CustomGreen"), lineWidth: 2)
                )
                HStack{
                    Text("Email :")
                        .font(.headline)
                        .foregroundStyle(Color("CustomGreen"))
                    
                    Spacer()
                    Text(userData.email)
                        .font(.headline)
                        .foregroundStyle(Color("CustomGreen"))
                }
                .padding()
                .background(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color("CustomGreen"), lineWidth: 2)
                )
                
                
            }
         
            
            Spacer()
            
            
            
            Button(action: {
                userData.isLoggedIn = false
            }) {
                Text("Deconnexion")
                    .fontWeight(.bold)
                    .padding()
                    .background(Color("CustomYellow"))
                    .foregroundColor(Color("CustomGreen"))
                    .cornerRadius(10)
                    .frame(maxWidth: .infinity)
            }
            .padding(.bottom)
            
        }
        .padding()
    }
}

#Preview {
    UserProfile()
        .environmentObject(UserData())
}
