//
//  BarChartView.swift
//  Wallify
//
//  Created by Mahmut Özkan on 26.04.2025.
//

import SwiftUI

// 2. Tek bir bar görünümü
struct BarView: View {
    let bar: ChartBar
    let maxValue: Double
    var body: some View {
        VStack(spacing: 4) {
            Text("$\(Int(bar.value))")
                .font(.system(size: 10, weight: .light))
                .textShadow()

            GeometryReader { geo in
                VStack {
                    Spacer(minLength: 0)

                    // Ortalanmış bar görünümü
                    ZStack(alignment: .bottom) {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color("bgColor"))
                            .softInnerShadow(
                                RoundedRectangle(cornerRadius: 20),
                                spread: 0.3,
                                radius: 2
                            )
                            .frame(width: geo.size.width * 0.7)
                            .frame(maxWidth: .infinity, alignment: .center)
                    
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.purple)
                            .frame(height: CGFloat(maxValue == 0 ? 0 : bar.value / maxValue) * geo.size.height)
                            .frame(width: geo.size.width * 0.7)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .frame(maxWidth: .infinity) // GeometryReader içinde ortalama için
                }
            }
            .frame(height: 100)

            Text(bar.label)
                .font(.system(size: 10, weight: .light))
                .textShadow()
        }
        .frame(maxWidth: .infinity) // çağrıldığı yerde alanı eşit paylaştırır
    }
}

// 3. Bar Chart’ı bir araya getiren container
struct BarChartView: View {
    let data: [ChartBar]

    private var maxValue: Double {
        data.map(\.value).max() ?? 1
    }

    var body: some View {
        HStack(alignment: .bottom, spacing: 8) {
            ForEach(data) { bar in
                BarView(bar: bar, maxValue: maxValue)
            }
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .frame(height: 150)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color("bgColor"))
                .softOuterShadow()
        )
    }
}
