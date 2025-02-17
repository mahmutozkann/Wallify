//
//  SplashView.swift
//  Wallify
//
//  Created by Mahmut Özkan on 23.12.2024.
//

import SwiftUI

struct SplashView: View {
    @State private var displayedText: String = ""
    @State private var isTypingComplete = false
    @State private var isActive = true
    let fullText = "Wallify"
    let typingSpeed = 0.2
    
    var body: some View {
        ZStack {
            if isActive {
                Color(.systemBackground)
                    .ignoresSafeArea()
                
                Text(displayedText)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .italic()
                    .foregroundColor(.blue)
                    .onAppear {
                        startTypingAnimation()
                    }
                
            } else {
                MainView()
                    .environmentObject(SessionManager())
            }
        }
    }
    
    
    func startTypingAnimation() {
        var currentIndex = 0
        
        Timer.scheduledTimer(withTimeInterval: typingSpeed, repeats: true) { timer in
            if currentIndex < fullText.count {
                let index = fullText.index(fullText.startIndex, offsetBy: currentIndex)
                displayedText.append(fullText[index])
                currentIndex += 1
            } else {
                isTypingComplete = true
                timer.invalidate()
                isActive = false
            }
        }
    }
    
}




#Preview {
    SplashView()
}
