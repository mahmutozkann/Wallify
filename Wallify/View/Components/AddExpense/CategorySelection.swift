//
//  CategorySelection.swift
//  Wallify
//
//  Created by Mahmut Özkan on 2.06.2025.
//

import SwiftUI

struct CategorySelection: View {
    @Binding var isCategoryPickerPresented: Bool
    @Binding var categorySelection: String
    let categories: [(key: String, value: String)] 
    var body: some View {
        ZStack{
            Color("bgColor").opacity(0.4)
                .ignoresSafeArea()
                .onTapGesture {
                    withAnimation {
                        isCategoryPickerPresented = false
                    }
                }
                .zIndex(99)
            
            VStack(spacing: 0) {
                Picker("Select Category", selection: $categorySelection) {
                    ForEach(categories.sorted { $0.value < $1.value }, id: \.key) { cat in
                        Label(cat.value, systemImage: cat.key)
                            .tag(cat.key)
                    }
                }
                .pickerStyle(.wheel)
                .frame(maxWidth: .infinity, maxHeight: 150)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color("bgColor"))
                        .softOuterShadow()
                )
                .onChange(of: categorySelection) { _ in
                    withAnimation {
                        isCategoryPickerPresented = false
                    }
                }
            }
            .padding()
            .zIndex(100)
        }
    }
}
