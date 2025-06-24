//
//  DonutChartViewComponent.swift
//  Wallify
//
//  Created by Mahmut Özkan on 4.06.2025.
//

import SwiftUI

struct DonutChartViewComponent: View {
    let data: [ChartSlice]

    private var total: Double {
        data.map { $0.value }.reduce(0, +)
    }

    private func angle(for value: Double) -> Angle {
        .degrees(360 * value / total)
    }

    var body: some View {
        GeometryReader { geo in
            let size = geo.size.width
            ZStack {
                // Donut dilimleri
                ForEach(0..<data.count, id: \.self) { index in
                    let startAngle = data.prefix(index).map { angle(for: $0.value) }.reduce(.degrees(0), +)
                    let endAngle = startAngle + angle(for: data[index].value)

                    DonutSliceView(
                        startAngle: startAngle,
                        endAngle: endAngle,
                        color: data[index].color,
                        innerRadiusRatio: 0.6
                    )
                }

                // Ortadaki boşlukta harcama kategorileri ve değerleri
                VStack(spacing: 6) {
                    ForEach(data) { slice in
                        HStack(spacing: 6) {
                            Circle()
                                .fill(slice.color)
                                .frame(width: 8, height: 8)

                            Text(slice.label)
                                .font(.caption2)
                                .lineLimit(1)

                            Text("$\(String(format: "%.1f", slice.value))")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .padding(8)
                .frame(width: size * 0.65) // Donut’ın ortasına sığacak şekilde
            }
            .padding(16) 
            .frame(width: size, height: size)
    
        }
        .aspectRatio(1, contentMode: .fit)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color("bgColor"))
                .softOuterShadow()
        )
    }
}

struct DonutSliceView: View {
    let startAngle: Angle
    let endAngle: Angle
    let color: Color
    let innerRadiusRatio: CGFloat  // 0.0 - 1.0

    var body: some View {
        GeometryReader { geo in
            let width = geo.size.width
            let height = geo.size.height
            let radius = min(width, height) / 2
            let center = CGPoint(x: width / 2, y: height / 2)
            let innerRadius = radius * innerRadiusRatio

            Path { path in
                path.move(to: point(at: startAngle, radius: innerRadius, center: center))
                path.addArc(center: center, radius: innerRadius,
                            startAngle: startAngle, endAngle: endAngle, clockwise: false)

                path.addArc(center: center, radius: radius,
                            startAngle: endAngle, endAngle: startAngle, clockwise: true)

                path.closeSubpath()
            }
            .fill(color)
        }
    }

    private func point(at angle: Angle, radius: CGFloat, center: CGPoint) -> CGPoint {
        let radians = CGFloat(angle.radians)
        return CGPoint(
            x: center.x + cos(radians) * radius,
            y: center.y + sin(radians) * radius
        )
    }
}
