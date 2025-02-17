//
//  ContentView.swift
//  Wallify
//
//  Created by Mahmut Özkan on 22.12.2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var session = SessionManager()
    var body: some View {
        SplashView()
            .environmentObject(session)
    }
}

#Preview {
    ContentView()
}
