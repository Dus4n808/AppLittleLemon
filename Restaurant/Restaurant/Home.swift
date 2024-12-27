//
//  Home.swift
//  Restaurant
//
//  Created by Dusan Fama on 27.12.2024.
//

import SwiftUI


struct Home: View {
    
    
    var body: some View {
        TabView {
            Menu()
                .tabItem {
                    Label("Menu", systemImage: "list.dash")
                }
            UserProfile()
                .tabItem {
                    Label("Profile", systemImage: "person.circle")
                }
                
            
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    Home()
        .environmentObject(UserData())
}
