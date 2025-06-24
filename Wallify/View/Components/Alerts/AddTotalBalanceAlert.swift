//
//  AddTotalBalanceAlert.swift
//  Wallify
//
//  Created by Mahmut Özkan on 19.05.2025.
//

import SwiftUI

struct AddTotalBalanceAlert: View {
    var title: String = "Add to Total Balance"
    var buttonText: String = "Add"
    @Binding var amount: Double
    @Binding var isPresented: Bool
    var action: (() -> Void)? = nil

    @State private var amountString: String = ""
    @FocusState private var isTextFieldFocused: Bool

    var body: some View {
        if isPresented {
            ZStack {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        isPresented = false
                    }

                VStack(spacing: 16) {
                    Text(title)
                        .font(.headline)
                        .foregroundColor(.black)

                    TextField("0.00", text: $amountString)
                        .font(.system(size: 20, weight: .light))
                        .keyboardType(.decimalPad)
                        .textShadow()
                        .multilineTextAlignment(.leading)
                        .neumorphicField()
                        .focused($isTextFieldFocused)

                    MyButton(text: buttonText) {
                        if let value = Double(amountString) {
                            amount = value
                        }
                        isPresented = false
                        action?()
                    }
                    .frame(width: 200)
                }
                .padding()
                .background(Color("bgColor"))
                .cornerRadius(12)
                .shadow(radius: 20)
            }
            .zIndex(3)
            .animation(.easeInOut, value: isPresented)
            .transition(.opacity)
            .onAppear {
                amountString = ""
                isTextFieldFocused = true
            }
        }
    }
}
