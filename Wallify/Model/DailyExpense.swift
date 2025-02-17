//
//  DailyExpense.swift
//  Wallify
//
//  Created by Mahmut Özkan on 28.12.2024.
//

import Foundation

struct DailyExpense: Identifiable {
    let id = UUID()
    let day: String
    let amount: Double
}
