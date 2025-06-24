//
//  Expense.swift
//  Wallify
//
//  Created by Mahmut Özkan on 17.05.2025.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct Expense: Identifiable {
    var id: String
    var category: String
    var amount: Double
    var date: Date
}
