//
//  LoginPage.swift
//  Restaurant
//
//  Created by Dusan Fama on 27.12.2024.
//

import SwiftUI

struct LoginPage: View {
    @EnvironmentObject var userData: UserData
    @State private var errorMessage: String?
    
    var body: some View {
        VStack (spacing: 0){
            Image("Logo")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .padding()
            Spacer(minLength: 20)
            
            
            ScrollView{
                VStack {
                    
                    Text("Welcome to Little Lemon Restaurant")
                        .font(.title)
                        .bold()
                        .foregroundStyle(Color("CustomGreen"))
                        .multilineTextAlignment(.center)
                    
                    TextField("Prénom", text: $userData.firstName)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .padding()
                    TextField("Nom", text: $userData.lastName)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .padding()
                    
                    TextField("Email", text: $userData.email)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .keyboardType(.emailAddress)
                        .padding()
                    SecureField("Mot de passe", text: $userData.password)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .padding()
                    if let error = errorMessage {
                        Text(error)
                            .foregroundColor(.red) // Message en rouge
                            .font(.subheadline)   // Police plus petite
                            .multilineTextAlignment(.center) // Alignement centré
                            .padding(.top, 5)     // Espacement au-dessus
                    }
                    
                    
                    Button(action: {
                        signUp()
                    }) {
                        Text("Inscription")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color("CustomYellow"))
                            .foregroundColor(Color("CustomGreen"))
                            .cornerRadius(10)
                            .padding()
                    }
                    .disabled(userData.email.isEmpty || userData.password.isEmpty)
                    
                    
                }
            }
            
            
        }
        .edgesIgnoringSafeArea(.top)
    }
    
    private func signUp() {
        if userData.firstName.isEmpty || userData.lastName.isEmpty || userData.email.isEmpty || userData.password.isEmpty {
            errorMessage = "Veuillez remplir tous les champs"
        } else if !userData.email.contains("@") {
            errorMessage = "Veuillez entrer une adresse email valide"
        } else if userData.password.count < 6 {
            errorMessage = "Le mot de passe doit contenir au moins 6 caractères"
        } else {
            errorMessage = nil
            userData.isLoggedIn = true
        }
    }
    
    
}



#Preview {
    LoginPage()
        .environmentObject(UserData())
}
