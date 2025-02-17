//
//  Button.swift
//  Wallify
//
//  Created by Mahmut Özkan on 23.12.2024.
//

import SwiftUI

struct MyButton: View {
    var text: String
    var action: () -> Void
    
    var body: some View {
        GeometryReader { geometry in
            Button(action: action) {
                Text(text)
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.vertical, geometry.size.height * 0.1)
                    .padding(.horizontal, geometry.size.width * 0.1)
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.blue, Color.purple]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                        .cornerRadius(geometry.size.height * 0.1)
                        .shadow(color: Color.purple.opacity(0.5), radius: geometry.size.height * 0.05, x: 0, y: geometry.size.height * 0.03)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: geometry.size.height * 0.1)
                            .stroke(LinearGradient(
                                gradient: Gradient(colors: [Color.white.opacity(0.5), Color.clear]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ), lineWidth: geometry.size.height * 0.01)
                    )
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(PlainButtonStyle())
            .animation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0.3), value: text)
        }
        .padding(.top, 18)
        .frame(height: 70)
    }
}

#Preview {
    MyButton(text: "Button", action: customFunc)
}

func customFunc(){
    print("Hello World!")
}
