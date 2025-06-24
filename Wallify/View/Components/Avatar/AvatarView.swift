//
//  AvatarView.swift
//  Wallify
//
//  Created by Mahmut Özkan on 30.12.2024.
//

import SwiftUI

struct AvatarView: View {
    @State var size: CGFloat = 40
    var body: some View {
        
        ZStack {
            Circle()
                .stroke(Color.black, lineWidth: 2) // Siyah daire çerçevesi
                .frame(width: size, height: size)
            
            Image(systemName: "person")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: size * 0.6, height: size * 0.6)
                .foregroundColor(.black)
        }
        .frame(width: size, height: size)
        .shadow(radius: 4)
        
    }
}

#Preview {
    AvatarView()
}
