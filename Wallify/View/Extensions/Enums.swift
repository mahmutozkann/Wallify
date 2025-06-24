//
//  Enums.swift
//  Wallify
//
//  Created by Mahmut Özkan on 5.06.2025.
//

import Foundation

//MARK: Chart Date Range
enum ChartDateRange: String, CaseIterable {
    case thisWeek = "This Week"
    case thisMonth = "This Month"
    case thisYear = "This Year"
    case all = "All Time"
}

//MARK: Chart Types
enum ChartType: String, CaseIterable {
    case pie = "Pie Chart"
    case donut = "Donut Chart"
}
