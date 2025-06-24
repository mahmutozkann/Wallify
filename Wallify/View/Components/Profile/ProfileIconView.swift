//
//  ProfileIconView.swift
//  Wallify
//
//  Created by Mahmut Özkan on 8.05.2025.
//

import SwiftUI

struct ProfileIconView: View {
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 2)
                .frame(width: 103, height: 103)
            
            Image(systemName: "person")
                .resizable()
                .scaledToFill()
                .frame(width: 60, height: 60)
            }
        .padding(.top, 50)
    }
}

#Preview {
    ProfileIconView()
}
