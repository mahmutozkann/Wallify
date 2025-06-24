//
//  ProfileInfoRow.swift
//  Wallify
//
//  Created by Mahmut Özkan on 8.05.2025.
//

import SwiftUI

struct ProfileInfoRow: View {
    var iconName: String
    var infoText: String
    var body: some View {
        HStack{
            
            Image(systemName: iconName)
                .resizable()
                .frame(width: 13, height: 10)
                .foregroundStyle(Color.black)
            
            Text(verbatim: infoText)
                .font(.system(size: 16, weight: .thin))
                .foregroundColor(Color.black)
                .textShadow()
            
            Spacer()
        }
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color("bgColor"))
                .frame(width: 240, height: 35)
                .softOuterShadow()
        )
        .frame(width: 228, height: 25)
        .padding(.bottom, 16)
    }
}

