//
//  DailyExpenses.swift
//  Wallify
//
//  Created by Mahmut Özkan on 8.05.2025.
//

import SwiftUI

struct DailyExpenses: View {
    var dailyPrice: Int
    var body: some View {
        HStack(alignment: .top){
            Text("$")
                .foregroundStyle(Color.black.opacity(0.25))
                .font(.system(size: 24, weight: .semibold))
            Text("\(dailyPrice)")
                .foregroundStyle(Color.black.opacity(0.25))
                .font(.system(size: 40, weight: .semibold))
            
            Spacer()
            
            VStack {
                Spacer()
                Text("#Daily")
                    .foregroundStyle(Color.black.opacity(0.25))
                    .font(.system(size: 30, weight: .semibold))
                    .italic()
                Spacer()
            }
        }
        .textShadow(color: .black.opacity(0.15))
    }
}
