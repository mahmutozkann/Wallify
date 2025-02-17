//
//  MainView.swift
//  Wallify
//
//  Created by Mahmut Özkan on 23.12.2024.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var session: SessionManager
    
    var body: some View {
        ZStack{
            switch session.currentState {
            case .onboarding:
                OnboardingView()
            case .dashboard:
                SignInView()
            default:
                EmptyView()
            }
            
        }
        .animation(.easeInOut, value: session.currentState)
        .onAppear {
            session.configureCurrentState()
        }
    }
}

#Preview {
    MainView()
        .environmentObject(SessionManager())
}
