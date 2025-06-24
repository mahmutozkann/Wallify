//
//  WallifyApp.swift
//  Wallify
//
//  Created by Mahmut Özkan on 22.12.2024.
//

import SwiftUI
import Firebase




@main
struct WallifyApp: App {
    
    init(){
        FirebaseApp.configure()
    }
    
    @StateObject private var session = SessionManager()
    var body: some Scene {
        WindowGroup {
            SplashView()
                .environmentObject(session)
        }
    }
}
