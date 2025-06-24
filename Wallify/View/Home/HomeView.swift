//
//  HomeView.swift
//  Wallify
//
//  Created by Mahmut Özkan on 23.12.2024.
//

import SwiftUI
import Neumorphic

struct HomeView: View {
    @StateObject private var expenseViewModel = ExpenseViewModel()
    @Binding var selectedIntex: Int
    @State private var exportedFile: ExportedFile? = nil
    
    private var recentExpenses: [Expense] {
        expenseViewModel.expenses
            .filter { $0.category != "Income" }
            .sorted(by: { $0.date > $1.date })
            .prefix(6)
            .map { $0 }
    }
    
   
    var body: some View {
        
        NavigationStack {
            ZStack {
                Color("bgColor")
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    HeaderView(headerName: "Home", selectedIndex: $selectedIntex, viewModel: expenseViewModel, exportedFile: $exportedFile)
                        .padding(.horizontal, 20)
                    
                    ScrollView(showsIndicators: false) {
                        VStack(alignment: .leading, spacing: 16) {
                            
                            YearlyExpenses(yearlyPrice: Int(expenseViewModel.yearlyTotal))
                                .padding(.top, 24)
                            
                            MounthlyExpenses(mounthlyPrice: Int(expenseViewModel.monthlyTotal))
                            
                            DailyExpenses(dailyPrice: Int(expenseViewModel.dailyTotal))
                            
                            Text("Recent Expenses")
                                .font(.system(size: 20, weight: .semibold))
                                .textShadow()
                            
                            if recentExpenses.isEmpty {
                                Text("Henüz harcama yok.")
                                    .font(.system(size: 16, weight: .light))
                                    .foregroundColor(.black)
                                    .padding(.horizontal)
                                    .frame(height: 50)
                                    .frame(maxWidth: .infinity)
                                    .textShadow()
                                    .background(
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(Color("bgColor"))
                                            .softOuterShadow()
                                    )
                                   
                            } else {
                                LazyVGrid(columns: [GridItem(.flexible(), spacing: 20), GridItem(.flexible())], spacing: 16) {
                                    ForEach(recentExpenses, id: \.id) { exp in
                                        RecentCategoryRow(
                                            iconName: iconName(for: exp.category),
                                            categoryPrice: exp.amount
                                        )
                                    }
                                }
                            }
                            
                            Text("This Week's Summary")
                                .font(.system(size: 20, weight: .semibold))
                                .textShadow()
                                .padding(.top, 24)
                            
                            HStack {
                                IncomeExpensesItem(categoryPrice: expenseViewModel.weeklyExpenseTotal)
                                Spacer()
                                IncomeExpensesItem(categoryPrice: expenseViewModel.weeklyIncomeTotal, isIncome: true)
                            }
                            
                            Spacer(minLength: 40) // Scroll’un sonunda boşluk
                        }
                        .padding(.horizontal, 20)
                    }
                }
                .padding(.bottom, 50)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

func iconName(for category: String) -> String {
    let icons: [String: String] = [
        "Transportation": "bus",
        "Food": "fork.knife",
        "Shopping": "cart",
        "Social": "party.popper",
        "Other": "ellipsis",
        "Games": "gamecontroller",
        "Income": "arrow.up"
    ]
    return icons[category] ?? category
}
