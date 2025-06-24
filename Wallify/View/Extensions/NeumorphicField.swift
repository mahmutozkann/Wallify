//
//  NeumorphicField.swift
//  Wallify
//
//  Created by Mahmut Özkan on 26.04.2025.
//

import SwiftUI


extension View {
    func neumorphicField(width: CGFloat = 130, height: CGFloat = 40) -> some View {
        self
            .frame(width: width, height: height, alignment: .leading)
            .padding(.leading, 8)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color("bgColor"))
                    .softOuterShadow()
            )
    }
    
    func neumorphicTextField(height: CGFloat) -> some View{
        self
        .font(.system(size: 18))
        .padding(.horizontal, 16)
        .frame(height: height * 0.05)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color("bgColor"))
                .softOuterShadow()
        )
    }
}
