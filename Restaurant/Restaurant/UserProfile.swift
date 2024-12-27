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
                .foregroundColor(.blue)
                .padding(.top)
            Image("profile")
                .resizable()
                .scaledToFill()
                .frame(width: 120, height: 120)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(Color.blue, lineWidth: 3)
                )
                .shadow(radius: 5)
            VStack(alignment: .leading, spacing: 10) {
                HStack{
                    Text("Prénom :")
                        .font(.headline)
                        .foregroundColor(.gray)
                    Spacer()
                    Text(userData.firstName)
                        .font(.body)
                        .foregroundColor(.black)
                }
                HStack{
                    Text("Nom :")
                        .font(.headline)
                        .foregroundColor(.gray)
                    Spacer()
                    Text(userData.lastName)
                        .font(.body)
                        .foregroundColor(.black)
                }
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .shadow(color: .gray.opacity(0.3), radius: 5, x: 0, y: 2)
            .padding(.horizontal)
            
            Spacer()
            
            
            
            Button(action: {
                userData.isLoggedIn = false
            }) {
                Text("Deconnexion")
                    .fontWeight(.bold)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
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
