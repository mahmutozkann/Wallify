//
//  RecentCategoryRow.swift
//  Wallify
//
//  Created by Mahmut Özkan on 8.05.2025.
//

import SwiftUI

struct RecentCategoryRow: View {
    var iconName: String
    var categoryPrice: Double
    var body: some View {
        HStack {
            HStack(alignment: .center){
                Image(systemName: iconName)
                    .font(.system(size: 20, weight: .light))
                    .foregroundStyle(iconName == "arrow.up" ? .green : .black)
                    .frame(height: 48)
                Spacer()
                Text("$\(String(format: "%.1f", categoryPrice))")
                    .font(.system(size: 24, weight: .regular))
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
            }
            .frame(height: 50)
            .frame(maxWidth: .infinity)
            .padding(.horizontal)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color("bgColor"))
                    .softOuterShadow()
            )
            
        }
        .padding(.top, 10)
    }
}
