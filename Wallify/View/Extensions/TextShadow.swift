//
//  TextShadow.swift
//  Wallify
//
//  Created by Mahmut Özkan on 26.04.2025.
//

import SwiftUI

extension View {
    /// Varsayılan olarak siyah %25 opaklıkta, 4 radius ve (0,4) offset gölgeleme ekler.
    func textShadow(
        color: Color = .black.opacity(0.25),
        radius: CGFloat = 4,
        x: CGFloat = 0,
        y: CGFloat = 4
    ) -> some View {
        self.shadow(color: color, radius: radius, x: x, y: y)
    }
}
