//
//  RestaurantApp.swift
//  Restaurant
//
//  Created by Dusan Fama on 26.12.2024.
//

import SwiftUI
import SwiftData

@main
struct RestaurantApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(UserData())
                .environmentObject(ProductViewModel())
                .environmentObject(Cart())
        }
    }
}
