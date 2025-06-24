//
//  ChartBar.swift
//  Wallify
//
//  Created by Mahmut Özkan on 27.04.2025.
//

import Foundation

// 1. Model: Haftanın her günü için bar verisi
struct ChartBar: Identifiable {
    let id = UUID()
    let label: String    // "Mon", "Tue", …
    let value: Double    // O günkü değer
}
