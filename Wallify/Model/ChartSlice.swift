//
//  ChartSlice.swift
//  Wallify
//
//  Created by Mahmut Özkan on 10.05.2025.
//

import SwiftUI

struct ChartSlice: Identifiable {
    let id = UUID()
    let value: Double
    let color: Color
    let label: String
}
