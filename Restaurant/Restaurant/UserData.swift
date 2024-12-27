//
//  Item.swift
//  Restaurant
//
//  Created by Dusan Fama on 26.12.2024.
//

import Foundation
import SwiftData

class UserData: ObservableObject {
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isLoggedIn: Bool = false
}
