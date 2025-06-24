//
//  DateSelection.swift
//  Wallify
//
//  Created by Mahmut Özkan on 2.06.2025.
//

import SwiftUI

struct DateSelection: View {
    @Binding var isDatePickerPresented: Bool
    @Binding var expenseDate: Date
    var body: some View {
        ZStack{
            Color("bgColor").opacity(0.4)
                .ignoresSafeArea()
                .onTapGesture {
                    withAnimation {
                        isDatePickerPresented = false
                    }
                }
                .zIndex(99)
            
            
            VStack(spacing: 0) {
                DatePicker(
                    "Select Date",
                    selection: $expenseDate,
                    displayedComponents: .date
                )
                .onTapGesture(count: 99) {}
                .datePickerStyle(GraphicalDatePickerStyle())
                .labelsHidden()
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color("bgColor"))
                        .softOuterShadow()
                )
                
                MyButton(text: "Done") {
                    withAnimation {
                        isDatePickerPresented = false
                    }
                }
                .padding(.top, 20)
            }
            .padding()
            .zIndex(100)
        }
    }
}
