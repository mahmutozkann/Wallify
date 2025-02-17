//
//  HomeView.swift
//  Wallify
//
//  Created by Mahmut Özkan on 23.12.2024.
//

import SwiftUI

struct HomeView: View {
    @State private var totalExpenses: Double = 9876.33
    var body: some View {
       
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack (spacing: 20){
                    
                    //total expenses
                    TotalExpenseCard(amount: totalExpenses)
                    
                    //categorized expenses horizontally
                    HorizontalHistoryView()
                    
                    //weekly chart
                    MyChartView()
                    
                }
            }
            .navigationTitle("Expenses")
        }
        .navigationBarBackButtonHidden(true)
    }
}






#Preview {
    HomeView()
}
