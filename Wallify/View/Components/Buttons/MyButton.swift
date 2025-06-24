//
//  Button.swift
//  Wallify
//
//  Created by Mahmut Özkan on 23.12.2024.
//

import SwiftUI
import Neumorphic
import CoreHaptics

struct MyButton: View {
    var text: String
    var action: () -> Void
    @State private var trigger: Bool = false
    
    var body: some View {
        
        Button {
            action()
            trigger.toggle()
        } label: {
            Text(text)
                .fontWeight(.bold)
                .foregroundStyle(Color("logOutColor"))
        }
        .softButtonStyle(RoundedRectangle(cornerRadius: 10), pressedEffect: .hard)
        .sensoryFeedback(.impact(weight: .medium), trigger: trigger)
        
        
        
    }
}

#Preview {
    MyButton(text: "Button", action: customFunc)
}

func customFunc(){
    print("Hello World!")
}
