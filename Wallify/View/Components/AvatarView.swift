//
//  AvatarView.swift
//  Wallify
//
//  Created by Mahmut Özkan on 30.12.2024.
//

import SwiftUI

struct AvatarView: View {
    @State var name: String
    @State var size: CGFloat = 50
    var body: some View {
        
        Image(name)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: size, height: size)
            .cornerRadius(size / 2)
            .shadow(radius: 10)
        
    }
}

#Preview {
    AvatarView(name: "avatar")
}
