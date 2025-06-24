//
//  MyAlert.swift
//  Wallify
//
//  Created by Mahmut Özkan on 5.01.2025.
//

import SwiftUI

struct MyAlert: View {
    var title: String
    var message: String
    var buttonText: String = "OK"
    var action: (() -> Void)? = nil
    @Binding var isPresented: Bool
    
    var body: some View {
        if isPresented {
            ZStack {
                
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                // Alert Kutusu
                VStack(spacing: 16) {
                    Text(title)
                        .font(.headline)
                        .foregroundColor(.black)
                    
                    Text(message)
                        .font(.body)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                    
                    MyButton(text: buttonText) {
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
            .animation(.easeInOut, value: isPresented)
            .transition(.opacity)
        }
    }
}

#Preview {
    MyAlert(title: "This is Alert", message: "This is alert description", buttonText: "Ok", action: {
        //
    }, isPresented: .constant(true))
}
