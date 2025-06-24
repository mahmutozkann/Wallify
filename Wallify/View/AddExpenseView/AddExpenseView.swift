//
//  AddExpenseView.swift
//  Wallify
//
//  Created by Mahmut Özkan on 28.12.2024.
//

import SwiftUI
import Neumorphic

struct AddExpenseView: View {
    @StateObject private var vm = ExpenseViewModel()
    @Binding var selectedIndex: Int
    @State private var exportedFile: ExportedFile? = nil
    
    @State private var expenseName = ""
    @State private var categorySelection : String = "cart"
    @State private var isDatePickerPresented = false
    @State private var isCategoryPickerPresented = false
    @State private var isAddCategoryPresented = false
    
    private var allCategories: [(key: String, value: String)] {
        categories + vm.userCategories
    }
    
    private var selectedCategory: (key: String, value: String) {
        allCategories.first { $0.key == categorySelection } ?? allCategories.first ?? ("ellipsis", "Other")
    }
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
    
    
    @State private var expenseDate = Date()
    @State private var amount: String = ""
    var body: some View {
        
        NavigationStack {
            ZStack {
                Color("bgColor")
                    .ignoresSafeArea()
                
                VStack{
                    
                    HeaderView(headerName: "Add Expense", selectedIndex: $selectedIndex, viewModel: vm, exportedFile: $exportedFile)
                    
                    HStack {
                        Text("Amount")
                            .font(.system(size: 20, weight: .light))
                            .textShadow()
                            .neumorphicField()
                        
                        Spacer()
                        
                        TextField("0.00", text: $amount)
                            .font(.system(size: 20, weight: .light))
                            .keyboardType(.numberPad)
                            .textShadow()
                            .multilineTextAlignment(.leading)
                            .neumorphicField()
                    }
                    .padding(.bottom, 16)
                    
                    HStack {
                        Text(selectedCategory.value)
                            .font(.system(size: 20, weight: .light))
                            .textShadow()
                            .neumorphicField()
                        
                        Spacer()
                        
                        Button(action: {
                            isAddCategoryPresented = true
                        }) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(.thickMaterial)
                                    .frame(width: 20, height: 20)
                                    .background(
                                        Circle()
                                            .stroke(Color.gray.opacity(0.4), lineWidth: 0.5)
                                    )
                                
                                Image(systemName: "plus")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 9, height: 9)
                                    .foregroundColor(.red)
                            }
                        }
                        
                        Button(action: {
                            isCategoryPickerPresented = true
                            isDatePickerPresented = false
                        }) {
                            HStack {
                                Spacer()
                                Image(systemName: selectedCategory.key)
                                Spacer()
                            }
                            .font(.system(size: 20, weight: .light))
                            .foregroundColor(.primary)
                            .neumorphicField()
                            .frame(height: 48)
                        }
                    }
                    .padding(.bottom, 16)
                    
                    HStack {
                        Text("Date")
                            .font(.system(size: 20, weight: .light))
                            .textShadow()
                            .neumorphicField()
                        
                        Spacer()
                        
                        Button(action: {
                            withAnimation {
                                isDatePickerPresented = true
                                isCategoryPickerPresented = false
                            }
                        }) {
                            Text(dateFormatter.string(from: expenseDate))
                                .font(.system(size: 20, weight: .light))
                                .foregroundColor(.primary)
                                .neumorphicField()
                                .frame(height: 48)
                        }
                        
                    }
                    .padding(.bottom, 16)
                    
                    MyButton(text: "Add Expense") {
                        guard let amt = Double(amount) else { return }
                        vm.addExpense(
                            name: expenseName,
                            category: selectedCategory.key,
                            amount: amt,
                            date: expenseDate
                        )
                        
                        // Inputları sıfırla
                        expenseName = ""
                        categorySelection = categories.first?.key ?? "cart"
                        amount = ""
                        expenseDate = Date()
                        
                        // Home'a dön
                        selectedIndex = 0
                    }
                    
                    Spacer()
                    
                }
                .padding(.horizontal, 20)
                
                if isDatePickerPresented {
                    // Karartma arka planı
                    DateSelection(isDatePickerPresented: $isDatePickerPresented, expenseDate: $expenseDate)
                }
                
                if isCategoryPickerPresented {
                    CategorySelection(
                        isCategoryPickerPresented: $isCategoryPickerPresented,
                        categorySelection: $categorySelection,
                        categories: allCategories
                    )
                }
            }
            .ignoresSafeArea(.keyboard, edges: .bottom)
            .onTapGesture {
                UIApplication.shared.sendAction(
                    #selector(UIResponder.resignFirstResponder),
                    to: nil, from: nil, for: nil
                )
            }
            .onAppear {
                vm.fetchUserCategories()
            }
            .sheet(isPresented: $isAddCategoryPresented) {
                AddCategoryView(viewModel: vm)
            }
            
        }
        .navigationBarBackButtonHidden(true)
        
        
    }
}
