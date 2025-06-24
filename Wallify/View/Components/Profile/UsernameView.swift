//
//  UsernameView.swift
//  Wallify
//
//  Created by Mahmut Özkan on 8.05.2025.
//

import SwiftUI

struct UsernameView: View {
    var name: String
    var surname: String
    var body: some View {
        HStack {
            Text(name)
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(.black)
                .textShadow()
            Text(surname)
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(.black)
                .textShadow()
        }
        .padding(.top, 20)
        .padding(.bottom, 20)
    }
}

