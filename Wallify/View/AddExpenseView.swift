//
//  AddExpenseView.swift
//  Wallify
//
//  Created by Mahmut Özkan on 28.12.2024.
//

import SwiftUI

struct AddExpenseView: View {
    @State private var expenseName = ""
    @State private var categorySelection : String = "cart"
    @State private var expenseDate = Date.now
    @State private var amount: Int = 0
    var body: some View {
        
        NavigationStack {
            ScrollView{
                VStack{
                    ZStack{
                        VStack{
                            TextField("Expense Name", text: $expenseName)
                                .padding(10)
                                .background(Color.white)
                                .cornerRadius(20)
                            
                            TextField("Amount", value: $amount, format: .number)
                                .padding(10)
                                .background(Color.white)
                                .cornerRadius(20)
                                .keyboardType(.numberPad)
                        }
                    }
                    .padding()
                    .background(Color.gray.opacity(0.7))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                    
                    
                    HStack{
                        Text("Category")
                        Spacer()
                        Picker("Category", selection: $categorySelection) {
                            // Sıralı listeyi kullanarak
                            ForEach(categories, id: \.key) { key, value in
                                Text(value) // Kullanıcıya gösterilecek metin
                                    .tag(key) // Sistem tarafından kullanılan anahtar
                            }
                        }
                    }
                    .padding()
                    
                    
                    
                    Image(systemName: categorySelection)
                        .frame(width: 52, height: 52)
                        .foregroundStyle(.black)
                        .overlay{
                            RoundedRectangle(cornerRadius: 15)
                                .strokeBorder(style: StrokeStyle(lineWidth: 1, dash: [8]))
                                .foregroundStyle(.black)
                        }
                    
                    HStack{
                        DatePicker(selection: $expenseDate, in: ...Date.now, displayedComponents: .date) {
                            Text("Select a date")
                        }
                    }
                    .padding()
                    
                    Text("Date is \(expenseDate.formatted(date: .long, time: .omitted))")
                    
                    MyButton(text: "Save") {
                        //save expense
                    }
                    
                }
                .padding()
            }
            .navigationTitle("Add Expense")
        }
        .navigationBarBackButtonHidden(true)
            
        
    }
}

#Preview {
    AddExpenseView()
}
