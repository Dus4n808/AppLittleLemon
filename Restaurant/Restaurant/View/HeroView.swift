//
//  HeroView.swift
//  Restaurant
//
//  Created by Dusan Fama on 05.01.2025.
//

import SwiftUI
import SwiftData

struct HeroView: View {
    @Binding  var searchText: String
    var body: some View {
        ZStack{
            Rectangle()
                .fill(Color("CustomGreen"))
                .frame(maxWidth: .infinity, minHeight: 80, maxHeight: 300)
            VStack (alignment: .leading){
                Text("Little Lemon")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(Color("CustomYellow"))
                Text("Chicago")
                    .font(.title2)
                    .foregroundStyle(.white)
                
                HStack{
                    Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
                    .font(.footnote)
                    .foregroundStyle(.white)
                    Image("Hero image")
                        .resizable()
                        .frame(width: 130, height: 130)
                        .clipShape(.buttonBorder)
                }
                HStack{
                    Image(systemName: "magnifyingglass") // Icône de loupe
                        .foregroundColor(Color("CustomGreen")) // Couleur de l'icône
                    TextField("Search...", text: $searchText) // Placeholder
                        .foregroundColor(Color("CustomGreen")) // Texte de recherche
                        .disableAutocorrection(true)
                }
                .padding()
                .background(Color("CustomYellow"))
                .cornerRadius(10)
                .frame(minHeight: 40)
            }
            .padding()
        }
            
    }
}

