//
//  SessionManager.swift
//  Wallify
//
//  Created by Mahmut Özkan on 23.12.2024.
//
import Foundation

final class SessionManager: ObservableObject{
    enum UserDefaultKeys{
        static let hasSeenOnboarding = "hasSeenOnboarding"
    }
    
    enum CurrentState{
        case onboarding
        case dashboard
    }
    
    @Published private(set) var currentState: CurrentState?
    
    func configureCurrentState(){
        let hasCompletedOnboarding = UserDefaults.standard.bool(forKey: UserDefaultKeys.hasSeenOnboarding)
        currentState = hasCompletedOnboarding ? .dashboard : .onboarding
    }
    
    func completeOnboarding(){
        currentState = .dashboard
        UserDefaults.standard.set(true, forKey: UserDefaultKeys.hasSeenOnboarding)
    }
    
}

