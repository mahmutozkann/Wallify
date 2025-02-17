//
//  AvatarIconView.swift
//  Wallify
//
//  Created by Mahmut Özkan on 30.12.2024.
//

import SwiftUI

struct AvatarIconView: View {
    @State var name: String
    let size: CGFloat = 70
    var action : () -> Void
    var body: some View {
        Button (action: action){

            Image(systemName: name)
                .frame(width: 52, height: 52)
                .foregroundStyle(.black)
                .overlay{
                    RoundedRectangle(cornerRadius: 15)
                        .strokeBorder(style: StrokeStyle(lineWidth: 1, dash: [8]))
                        .foregroundStyle(.black)
                }
        }
    }
}


#Preview {
    AvatarIconView(name: "fork.knife", action: customFunc)
}
