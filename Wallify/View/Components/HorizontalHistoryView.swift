//
//  HorizontalHistoryView.swift
//  Wallify
//
//  Created by Mahmut Özkan on 30.12.2024.
//

import SwiftUI

struct HorizontalHistoryView: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack{
                ForEach(categories, id: \.key) { category in
                    AvatarIconView(name: category.key) {
                        // expenses history view
                    }
                }
                .padding(5)
            }
        }
    }
}



#Preview {
    HorizontalHistoryView()
}
