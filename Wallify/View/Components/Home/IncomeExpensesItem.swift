//
//  IncomeExpensesItem.swift
//  Wallify
//
//  Created by Mahmut Özkan on 25.05.2025.
//

import SwiftUI

struct IncomeExpensesItem: View {
    var categoryPrice: Double
    var isIncome: Bool = false
    var body: some View {
        HStack {
            HStack(alignment: .center){
                Image(systemName: isIncome ? "arrow.up" : "arrow.down")
                    .resizable()
                    .frame(width: 16, height: 24)
                    .foregroundStyle(isIncome ? .green : .red)
                Spacer()
                Text("$\(String(format: "%.1f", categoryPrice))")
                    .font(.system(size: 24, weight: .regular))
            }
            .frame(width: 120, height: 50)
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

#Preview {
    IncomeExpensesItem(categoryPrice: 34)
}
