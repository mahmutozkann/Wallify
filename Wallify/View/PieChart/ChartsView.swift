//
//  PieChartView.swift
//  Wallify
//
//  Created by Mahmut Özkan on 26.12.2024.
//

import SwiftUI

struct ChartsView: View {
    
   
    
    @Binding var selectedIndex: Int
    @StateObject private var expenseViewModel = ExpenseViewModel()
    @State private var selectedChart: ChartType = .donut
    @State private var selectedRange: ChartDateRange = .thisMonth
    @State private var exportedFile: ExportedFile? = nil
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("bgColor")
                    .ignoresSafeArea()
                
                VStack{
                    HeaderView(headerName: "Chart", selectedIndex: $selectedIndex, viewModel: expenseViewModel, exportedFile: $exportedFile)
                        .padding(.horizontal, 20)
                    
                    ScrollView(showsIndicators: false){
                        VStack{
                            
                            HStack{
                                Menu {
                                    ForEach(ChartType.allCases, id: \.self) { chart in
                                        Button(chart.rawValue) {
                                            withAnimation {
                                                selectedChart = chart
                                            }
                                        }
                                    }
                                } label: {
                                    HStack {
                                        Text(selectedChart.rawValue)
                                            .font(.system(size: 20, weight: .light))
                                            .foregroundStyle(.black)
                                            .textShadow()
                                            .neumorphicField()
                                        
                                        Image(systemName: "chevron.down")
                                            .foregroundStyle(.myBlue)
                                    }
                                }
                                
                                Spacer()
                                
                                Menu {
                                       ForEach(ChartDateRange.allCases, id: \.self) { range in
                                           Button(range.rawValue) {
                                               withAnimation {
                                                   selectedRange = range
                                               }
                                           }
                                       }
                                   } label: {
                                       HStack {
                                           Text(selectedRange.rawValue)
                                               .font(.system(size: 20, weight: .light))
                                               .foregroundStyle(.black)
                                               .textShadow()
                                               .neumorphicField()
                                           
                                           Image(systemName: "chevron.down")
                                               .foregroundStyle(.myBlue)
                                       }
                                   }
                            }
                            .padding(.bottom, 16)
                            .padding(.top, 12)
                            
                            Group {
                                switch selectedChart {
                                case .pie:
                                    PieChartViewComponent(data: expenseViewModel.chartSlices(for: selectedRange))
                                        .transition(.opacity)
                                case .donut:
                                    DonutChartViewComponent(data: expenseViewModel.chartSlices(for: selectedRange))
                                        .transition(.opacity)
                                }
                            }
                            .padding(.bottom, 16)
                            
                            if selectedChart == .pie {
                                // Legend
                                ForEach(expenseViewModel.chartSlices(for: selectedRange)) { slice in
                                       HStack {
                                           Circle()
                                               .fill(slice.color)
                                               .frame(width: 12, height: 12)
                                           Text(slice.label)
                                               .font(.caption)
                                           Spacer()
                                           Text("$\(String(format: "%.1f", slice.value))")
                                               .font(.caption)
                                               .foregroundStyle(.secondary)
                                       }
                                   }
                            }
                            
                            Spacer(minLength: 40)
                        }
                        .padding(.horizontal, 20)
                    }
                }
                .padding(.bottom, 50)
                .onAppear {
                    expenseViewModel.fetchUserCategories()
                }
            }
        }
    }
}
