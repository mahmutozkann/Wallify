//
//  ExpenseHistory.swift
//  Wallify
//
//  Created by Mahmut Özkan on 3.06.2025.
//

import SwiftUI
import Neumorphic

struct ExpenseHistory: View {
    var iconName: String
    var category: String
    var categoryPrice: Double
    var date: Date
    var action: () -> Void
    var body: some View {
        HStack {
            VStack {
                HStack (alignment: .center){
                    HStack{
                        Image(systemName: iconName)
                            .font(.system(size: 20, weight: .light))
                            .foregroundStyle(iconName == "arrow.up" ? .green : .black)
                            .frame(height: 48)
                        
                        Text(category)
                            .font(.system(size: 24, weight: .regular))
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                        
                        Spacer()
                        
                        Text("$\(String(format: "%.1f", categoryPrice))")
                            .font(.system(size: 24, weight: .regular))
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                        
                    }
                    .padding(.horizontal)
                   
                    
                    Button {
                        // Silme işlemi
                        action()
                    } label: {
                        ZStack {
                            Circle()
                                .fill(.thickMaterial)
                                .frame(width: 40, height: 40)
                                .background(
                                    Circle()
                                        .stroke(Color.gray.opacity(0.2), lineWidth: 0.5) // Hafif kenar çizgisi
                                )
                            
                            Image(systemName: "trash")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 18, height: 18)
                                .foregroundColor(.red)
                        }
                    }
                    .padding(.trailing)
                }
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color("bgColor"))
                        .softOuterShadow()
                )
                
                HStack{
                    Text(date.formatted(date: .abbreviated, time: .omitted))
                        .font(.system(size: 14, weight: .light))
                        .italic()
                    Spacer()
                }
            }
        }
    }
}
