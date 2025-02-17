//
//  User.swift
//  Wallify
//
//  Created by Mahmut Özkan on 5.01.2025.
//

import SwiftUI

struct User: Identifiable {
    let id = UUID()
    let name: String
    let surname: String
    let email: String
    let password: String
}


