//
//  MounthlyExpenses.swift
//  Wallify
//
//  Created by Mahmut Özkan on 8.05.2025.
//

import SwiftUI

struct MounthlyExpenses: View {
    var mounthlyPrice: Int
    var body: some View {
        HStack(alignment: .top){
            Text("$")
                .foregroundStyle(Color.black.opacity(0.5))
                .font(.system(size: 24, weight: .semibold))
            Text("\(mounthlyPrice)")
                .foregroundStyle(Color.black.opacity(0.5))
                .font(.system(size: 40, weight: .semibold))
            
            Spacer()
            
            VStack {
                Spacer()
                Text("#Mounthly")
                    .foregroundStyle(Color.black.opacity(0.5))
                    .font(.system(size: 30, weight: .semibold))
                    .italic()
                Spacer()
            }
        }
        .textShadow()
    }
}
