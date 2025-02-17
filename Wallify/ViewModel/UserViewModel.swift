//
//  ProfileViewModel.swift
//  Wallify
//
//  Created by Mahmut Özkan on 5.01.2025.
//

import SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var user: User
    
    init(user: User) {
        self.user = user
    }
}

let sampleUser: User =  User(name: "Mahmut", surname: "Özkan", email: "mahmut@wallify.com", password: "password")
