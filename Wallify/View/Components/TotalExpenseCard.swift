//
//  TotalExpenseCard.swift
//  Wallify
//
//  Created by Mahmut Özkan on 28.12.2024.
//

import SwiftUI

struct TotalExpenseCard: View {
    let amount: Double
    
    @State private var showAddExpense = false
    var body: some View {
        VStack(alignment: .leading){
            
            
            AvatarView(name: "avatar", size: 50)
            
            Text("Total Expenses")
                .font(.headline)
                .foregroundStyle(.gray)
            
            Text("$\(amount, specifier: "%.2f")")
                .font(.system(size: 34, weight: .bold))
                .foregroundStyle(.myBlue)
            
            HStack {
                Button(action: {
                    // add expense view
                }){
                    Text("Add")
                        .fontWeight(.semibold)
                }
                .foregroundStyle(.white)
                .padding(8)
                .background(.red, in: .capsule)
                
                Image(systemName: "arrow.up")
                
                //today information
                Text("+$16.33 today")
                    .foregroundStyle(.gray)
                    .font(.callout)
                
                Spacer()
            }
            
            
        }
        .frame(maxWidth: .infinity,maxHeight: 250, alignment: .leading)
        .padding()
        
    }
}


#Preview {
    TotalExpenseCard(amount: 1250.50)
}
