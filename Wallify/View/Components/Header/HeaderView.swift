//
//  HeaderView.swift
//  Wallify
//
//  Created by Mahmut Özkan on 23.04.2025.
//

import SwiftUI
import Neumorphic

struct HeaderView: View {
    var headerName: String = "Add Expense"
    @Binding var selectedIndex: Int
    
    @State private var showExportSheet = false
    @State private var fileURL: URL? = nil
    @ObservedObject var viewModel: ExpenseViewModel
    @Binding var exportedFile: ExportedFile?
    
    var body: some View {
        HStack{
            AvatarView()
                .onTapGesture {
                    selectedIndex = 4
                }
            
            Spacer()
            
            Text(headerName)
                .font(.system(size: 20, weight: .light))
                .textShadow()
            
            Spacer()
            
            Button {
                if let url = viewModel.exportExpensesToCSV() {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        if FileManager.default.fileExists(atPath: url.path) {
                            exportedFile = ExportedFile(url: url)
                        } else {
                            print("❗️CSV dosyası yazılamadı veya bulunamadı: \(url)")
                        }
                    }
                }
            } label: {
                Image(systemName: "newspaper.fill")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundStyle(Color.black.opacity(0.4))
                    .textShadow()
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color("bgColor"))
                .frame(height: 50)
                .softOuterShadow()
        )
        .sheet(item: $exportedFile) { file in
            DocumentExporter(url: file.url)
        }
    }
}

struct ExportedFile: Identifiable {
    let id = UUID()
    let url: URL
}
