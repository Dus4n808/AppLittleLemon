//
//  Item.swift
//  Restaurant
//
//  Created by Dusan Fama on 26.12.2024.
//

import Foundation
import SwiftData

@Model
class UserData: ObservableObject {
    var firstName: String = ""
    var lastName: String = ""
    var email: String = ""
    var password: String = ""
    var isLoggedIn: Bool = false

    init(firstName: String = "", lastName: String = "", email: String = "", password: String = "", isLoggedIn: Bool = false) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.password = password
        self.isLoggedIn = isLoggedIn
    }
}
