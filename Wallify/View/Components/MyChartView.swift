//
//  MyChartView.swift
//  Wallify
//
//  Created by Mahmut Özkan on 28.12.2024.
//

import SwiftUI
import Charts

struct MyChartView: View {
    
    let weeklyExpenses: [DailyExpense] = [
        DailyExpense(day: "Monday", amount: 20),
        DailyExpense(day: "Tuesday", amount: 35),
        DailyExpense(day: "Wednesday", amount: 50),
        DailyExpense(day: "Thursday", amount: 40),
        DailyExpense(day: "Friday", amount: 70),
        DailyExpense(day: "Saturday", amount: 90),
        DailyExpense(day: "Sunday", amount: 30)
    ]
    
    var body: some View {
        
        VStack {
            Text("Weekly Expenses")
                .font(.title)
                .bold()
                .padding()
            
            Chart {
                ForEach(weeklyExpenses) { expense in
                    BarMark(
                        x: .value("Day", expense.day),
                        y: .value("Amount", expense.amount)
                    )
                    .foregroundStyle(.pink.gradient)
                    .cornerRadius(20)
                }
            }
            .frame(height: 180)
          //  .frame(width: .infinity)// Grafik boyutu
            .padding()
            
            MyButton(text: "Details") {
                //expense history view
            }
        }
    }
}


#Preview {
    MyChartView()
}
