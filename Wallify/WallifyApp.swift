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
    @AppStorage("isLoggedIn") var isLoggedIn = false
    var body: some Scene {
        WindowGroup {
            if isLoggedIn {
                MyTabView()
            }else{
                SplashView()
                    .environmentObject(session)
            }
        }
    }
}
