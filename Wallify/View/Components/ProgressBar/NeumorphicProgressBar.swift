//
//  NeumorphicProgressBar.swift
//  Wallify
//
//  Created by Mahmut Özkan on 26.04.2025.
//

import SwiftUI

struct NeumorphicProgressBar: View {
    /// 0.0 … 1.0 arasında bir değer
    var progress: CGFloat
    @State private var animatedProgress: CGFloat = 0.0
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                // 1) Alt zemin (track)
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color("bgColor"))
//                    .frame(height: 50)
                    .softInnerShadow(RoundedRectangle(cornerRadius: 20), spread: 0.3, radius: 2 )
                
                // 2) Doluluk (fill)
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.purple)
                // geo.size.width * progress oranı kadar genişlik
                    .frame(width: geo.size.width * animatedProgress, height: 10)
                    .padding(.horizontal, 5)
                    .textShadow()
                
            }
            .softOuterShadow(radius: 10)
            .onAppear {
                withAnimation(.easeOut(duration: 2)) {
                    animatedProgress = progress
                }
            }
        }
        .frame(height: 20)
        .onChange(of: progress) { newValue in
            withAnimation(.easeOut(duration: 2)) {
                animatedProgress = newValue
            }
        }
    }
}

