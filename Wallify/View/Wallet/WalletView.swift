//
//  WalletView.swift
//  Wallify
//
//  Created by Mahmut Özkan on 28.12.2024.
//

import SwiftUI
import Neumorphic

struct WalletView: View {
    
    @StateObject private var expenseViewModel = ExpenseViewModel()
    @State private var spendingViewModel: SpendingViewModel = SpendingViewModel(expenses: [])
    @State private var isPresented: Bool = false
    @State private var tempAmount: Double = 0.0
    @State private var progressID = UUID()
    @Binding var selectedIndex: Int
    @State private var exportedFile: ExportedFile? = nil
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color("bgColor")
                    .ignoresSafeArea()
                
                VStack{
                    HeaderView(headerName: "Wallet", selectedIndex: $selectedIndex, viewModel: expenseViewModel, exportedFile: $exportedFile)
                        .padding(.horizontal, 20)
                    
                    ScrollView(showsIndicators: false){
                        VStack{
                            ///Total Balance Card
                            VStack(alignment: .leading){
                                Text("Total Balance")
                                    .font(.system(size: 14, weight: .light))
                                    .padding(.bottom, 10)
                                    .textShadow()
                                
                                HStack(alignment: .center){
                                    Text(expenseViewModel.formattedBalance)
                                        .font(.system(size: 34, weight: .heavy))
                                        .textShadow()
                                    
                                    Spacer()
                                    
                                    MyButton(text: " + ") {
                                        //add total balance
                                        isPresented = true
                                    }
                                }
                                
                                NeumorphicProgressBar(progress: expenseViewModel.usedPercentage)
                                    .id(progressID) 
                                    .padding(.top, 16)
                                
                                HStack{
                                    Spacer()
                                    Text(String(format: "%.1f%% Used", expenseViewModel.usedPercentage * 100))
                                        .font(.system(size: 10, weight: .light))
                                        .textShadow()
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: 180)
                            .padding(.horizontal)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color("bgColor"))
                                    .softOuterShadow()
                                
                            )
                            .padding(.bottom, 16)
                            .padding(.top, 12)
                            
                            HStack{
                                Text("#Your Expenses")
                                    .font(.system(size: 14, weight: .light))
                                    .italic()
                                    .underline()
                                    .textShadow()
                                Spacer()
                            }
                            
                            BarChartView(data: spendingViewModel.weeklySpendingBars)
                                .padding(.bottom, 16)
                            
                            //Expenses History
                            HStack{
                                Text("#Your History")
                                    .font(.system(size: 14, weight: .light))
                                    .italic()
                                    .underline()
                                    .textShadow()
                                Spacer()
                            }
                            VStack{
                                ForEach(expenseViewModel.expenses){ expense in
                                    ExpenseHistory(
                                        iconName: iconName(for: expense.category),
                                        category: displayName(for: expense.category, userCategories: expenseViewModel.userCategories),
                                        categoryPrice: expense.amount,
                                        date: expense.date,
                                        action: {expenseViewModel.deleteExpense(expense)}
                                    )
                                }
                                .padding(.bottom, 6)
                            }
                            
                            Spacer(minLength: 40)
                        }
                        .padding(.horizontal, 20)
                    }
                }
                .padding(.bottom, 50)
      
            }
            .navigationBarBackButtonHidden(true)
            .overlay {
                AddTotalBalanceAlert(amount: $tempAmount, isPresented: $isPresented){
                    expenseViewModel.addIncome(amount: tempAmount)
                }
            }
            .onAppear {
                isPresented = false
                progressID = UUID()
                expenseViewModel.fetchUserCategories()
            }
            .onReceive(expenseViewModel.$expenses) { updatedExpenses in
                spendingViewModel = SpendingViewModel(expenses: updatedExpenses)
            }
        }
    }
}

func displayName(for category: String, userCategories: [(key: String, value: String)]) -> String {
    let defaultNames = [
        "bus": "Transportation",
        "fork.knife": "Food",
        "cart": "Shopping",
        "party.popper": "Social",
        "gamecontroller": "Games",
        "ellipsis": "Other",
        "arrow.up": "Income"
    ]
    
    // Ön tanımlı ikonlardansa, eşleşen adı döndür
    if let defaultName = defaultNames[category] {
        return defaultName
    }
    
    // Kullanıcı tarafından eklenmiş kategori varsa onu döndür
    if let match = userCategories.first(where: { $0.key == category }) {
        return match.value
    }
    
    // Hiçbiri değilse olduğu gibi göster
    return category
}
