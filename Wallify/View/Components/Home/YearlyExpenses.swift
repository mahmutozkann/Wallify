//
//  MounthlyExpenses.swift
//  Wallify
//
//  Created by Mahmut Özkan on 8.05.2025.
//

import SwiftUI

struct YearlyExpenses: View {
    var yearlyPrice: Int
    var body: some View {
        HStack(alignment: .top){
            Text("$")
                .font(.system(size: 24, weight: .semibold))
            Text("\(yearlyPrice)")
                .font(.system(size: 40, weight: .semibold))
            
            Spacer()
            
            VStack {
                Spacer()
                Text("#Yearly")
                    .font(.system(size: 30, weight: .semibold))
                    .italic()
                Spacer()
            }
        }
        .textShadow()
    }
}
