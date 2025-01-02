//
//  LoginPage.swift
//  Restaurant
//
//  Created by Dusan Fama on 27.12.2024.
//

import SwiftUI
import SwiftData

struct LoginPage: View {
    @Query var userData: [UserData]
    @Environment(\.modelContext) private var modelContext
    @State private var errorMessage: String?
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    
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
                    
                    TextField("Prénom", text: $firstName)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .padding()
                    TextField("Nom", text: $lastName)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .padding()
                    
                    TextField("Email", text: $email)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .keyboardType(.emailAddress)
                        .padding()
                    SecureField("Mot de passe", text: $password)
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
                    .disabled(email.isEmpty || password.isEmpty)
                    
                    
                }
            }
            
            
        }
        .edgesIgnoringSafeArea(.top)
    }
    
    private func signUp() {
            // Validation des champs
            if firstName.isEmpty || lastName.isEmpty || email.isEmpty || password.isEmpty {
                errorMessage = "Veuillez remplir tous les champs"
            } else if !email.contains("@") {
                errorMessage = "Veuillez entrer une adresse email valide"
            } else if password.count < 6 {
                errorMessage = "Le mot de passe doit contenir au moins 6 caractères"
            } else {
                // Ajout ou mise à jour de l'utilisateur dans SwiftData
                if let existingUser = userData.first {
                    existingUser.firstName = firstName
                    existingUser.lastName = lastName
                    existingUser.email = email
                    existingUser.password = password
                    existingUser.isLoggedIn = true
                } else {
                    let newUser = UserData(
                        firstName: firstName,
                        lastName: lastName,
                        email: email,
                        password: password,
                        isLoggedIn: true
                    )
                    modelContext.insert(newUser)
                }
                try? modelContext.save()
                errorMessage = nil
            }
        }
    
    
}



#Preview {
    LoginPage()
        .modelContainer(for: UserData.self)
}
