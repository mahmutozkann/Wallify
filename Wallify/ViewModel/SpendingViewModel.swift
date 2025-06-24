//
//  SpendingViewModel.swift
//  Wallify
//
//  Created by Mahmut Özkan on 31.05.2025.
//

import Foundation

class SpendingViewModel: ObservableObject {
    let expenses: [Expense]
    
    init(expenses: [Expense]) {
        self.expenses = expenses
    }
    
    var weeklySpendingBars: [ChartBar] {
        let calendar = Calendar.current
        let now = Date()
        let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: now))!
        
        var dailyTotals: [Int: Double] = [:]

        for expense in expenses {
            let weekday = calendar.component(.weekday, from: expense.date)
            if expense.date >= startOfWeek && expense.category != "Income" {
                dailyTotals[weekday, default: 0.0] += expense.amount
            }
        }

        let days: [(Int, String)] = [
            (2, "Mon"), (3, "Tue"), (4, "Wed"),
            (5, "Thu"), (6, "Fri"), (7, "Sat"), (1, "Sun")
        ]

        return days.map { (dayNumber, label) in
            ChartBar(label: label, value: dailyTotals[dayNumber] ?? 0)
        }
    }
}
