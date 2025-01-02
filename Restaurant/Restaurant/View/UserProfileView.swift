//
//  UserProfile.swift
//  Restaurant
//
//  Created by Dusan Fama on 27.12.2024.
//

import SwiftUI
import SwiftData


struct UserProfile: View {
    @Query var userData: [UserData]
    @Environment(\.modelContext) private var modelContext
    @State private var isEditing: Bool = false
    @State private var updateLastName: String = ""
    @State private var updateEmail: String = ""
    @State private var updateFirstName: String = ""
    var body: some View {
        VStack (spacing: 20){
            Text("Informations Personelles")
                .font(.title)
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
            if let user = userData.first {
                VStack(alignment: .leading, spacing: 10) {
                    if isEditing {
                        HStack {
                            Text("Prénom :")
                                .font(.headline)
                                .foregroundStyle(Color("CustomGreen"))
                            
                            Spacer()
                            TextField("Prénom", text: $updateFirstName)
                                .font(.headline)
                                .foregroundColor(Color("CustomGreen"))
                                .multilineTextAlignment(.trailing)
                                .padding(.horizontal)
                        }
                        .padding()
                        .background(Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color("CustomGreen"), lineWidth: 2)
                        )
                        
                        HStack {
                            Text("Nom :")
                                .font(.headline)
                                .foregroundStyle(Color("CustomGreen"))
                            
                            Spacer()
                            TextField("Nom", text: $updateLastName)
                                .font(.headline)
                                .foregroundColor(Color("CustomGreen"))
                                .multilineTextAlignment(.trailing)
                                .padding(.horizontal)
                        }
                        .padding()
                        .background(Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color("CustomGreen"), lineWidth: 2)
                        )
                        
                        HStack {
                            Text("Email :")
                                .font(.headline)
                                .foregroundStyle(Color("CustomGreen"))
                            
                            Spacer()
                            TextField("Email", text: $updateEmail)
                                .font(.headline)
                                .foregroundColor(Color("CustomGreen"))
                                .multilineTextAlignment(.trailing)
                                .padding(.horizontal)
                        }
                        .padding()
                        .background(Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color("CustomGreen"), lineWidth: 2)
                        )
                        
                        Button("Valider") {
                            user.firstName = updateFirstName
                            user.lastName = updateLastName
                            user.email = updateEmail
                            try? modelContext.save()
                            isEditing = false
                        }
                        .fontWeight(.bold)
                        .padding()
                        .background(Color("CustomYellow"))
                        .foregroundColor(Color("CustomGreen"))
                        .cornerRadius(10)
                        .frame(alignment: .center)
                    } else {
                        HStack{
                            Text("Prénom :")
                                .font(.headline)
                                .foregroundStyle(Color("CustomGreen"))
                            
                            Spacer()
                            Text(user.firstName)
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
                            Text(user.lastName)
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
                            Text(user.email)
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
                }
                .onAppear {
                    updateFirstName = user.firstName
                    updateLastName = user.lastName
                    updateEmail = user.email
                }
            }
            
            
            Spacer()
            
            
            
            Button(action: {
                if let user = userData.first {
                    user.isLoggedIn = false
                    try? user.modelContext?.save()
                    
                }
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
        .toolbar {
            ToolbarItem (placement: .navigationBarTrailing){
                Button(isEditing ? "Annuler": "Modifier") {
                    isEditing.toggle()
                }
            }
        }
    }
}

#Preview {
    UserProfile()
        .modelContainer(for: UserData.self)
}
