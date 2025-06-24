//
//  SplashView.swift
//  Wallify
//
//  Created by Mahmut Özkan on 23.12.2024.
//
import SwiftUI

struct SplashView: View {
    @AppStorage("isLoggedIn") var isLoggedIn = false
    @EnvironmentObject var session: SessionManager
    @State private var displayedText: String = ""
    @State private var isTypingComplete = false
    @State private var shouldNavigate = false
    
    private let fullText = "Wallify"
    private let typingSpeed = 0.2
    
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea()
            
            if shouldNavigate {
                if isLoggedIn {
                    MyTabView()
                } else {
                    SignInView()
                        .environmentObject(session)
                }
            } else {
                Text(displayedText)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .italic()
                    .foregroundColor(.purple)
                    .onAppear {
                        typeText()
                    }
            }
        }
    }
    
    func typeText() {
        Task {
            for char in fullText {
                displayedText.append(char)
                try? await Task.sleep(nanoseconds: UInt64(typingSpeed * 1_000_000_000))
            }
            
            // Delay before navigating to main content
            try? await Task.sleep(nanoseconds: 1_000_000_000) // 1 second
            withAnimation {
                shouldNavigate = true
            }
        }
    }
}
