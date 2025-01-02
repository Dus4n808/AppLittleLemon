//
//  ContentView.swift
//  Restaurant
//
//  Created by Dusan Fama on 26.12.2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Query var userData: [UserData]
    
    
    
    var body: some View {
        if let user = userData.first, user.isLoggedIn {
            ViewMenu()
        } else {
            LoginPage()
        }
    }
}




#Preview {
    ContentView()
        .modelContainer(for: UserData.self)
}
