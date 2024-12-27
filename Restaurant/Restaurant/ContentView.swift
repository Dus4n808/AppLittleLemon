//
//  ContentView.swift
//  Restaurant
//
//  Created by Dusan Fama on 26.12.2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @EnvironmentObject var userData: UserData
    
    
    
    var body: some View {
        if userData.isLoggedIn {
            Home()
        } else {
            LoginPage()
        }
    }
}




#Preview {
    ContentView()
        .environmentObject(UserData())
}
