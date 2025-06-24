//
//  PieChartView.swift
//  Wallify
//
//  Created by Mahmut Özkan on 10.05.2025.
//

import SwiftUI

struct PieChartViewComponent: View {
    let data: [ChartSlice]

    private var total: Double {
        data.map { $0.value }.reduce(0, +)
    }

    private func angle(for value: Double) -> Angle {
        .degrees(360 * value / total)
    }

    var body: some View {
        ZStack {
            GeometryReader { geo in
                ZStack {
                    ForEach(0..<data.count, id: \.self) { index in
                        let startAngle = data.prefix(index).map { angle(for: $0.value) }.reduce(.degrees(0), +)
                        let endAngle = startAngle + angle(for: data[index].value)

                        PieSliceView(
                            startAngle: startAngle,
                            endAngle: endAngle,
                            color: data[index].color
                        )
                    }
                }
                .frame(width: geo.size.width, height: geo.size.width)
            }
        }
        .aspectRatio(1, contentMode: .fit)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color("bgColor"))
                .softOuterShadow()
        )
        .frame(maxWidth: .infinity)
//        .padding(.horizontal, 20) // HeaderView ile aynı hizalanır
    }
}


struct PieSliceView: View {
    let startAngle: Angle
    let endAngle: Angle
    let color: Color

    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
            let inset: CGFloat = 12 // ← buradan kenar boşluğu kontrol edilir
            let radius = (min(width, height) - inset * 2) / 2
            let center = CGPoint(x: width / 2, y: height / 2)

            Path { path in
                path.move(to: center)
                path.addArc(center: center,
                            radius: radius,
                            startAngle: startAngle,
                            endAngle: endAngle,
                            clockwise: false)
            }
            .fill(color)
        }
    }
}

