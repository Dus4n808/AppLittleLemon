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
        VStack {
            Text("Inscription")
                .font(.largeTitle)
                .bold()
            
            
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
                Text("Insciption")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
                    .padding()
            }
            .disabled(userData.email.isEmpty || userData.password.isEmpty)
            
            
            
            
        }
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
