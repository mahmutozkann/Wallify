// AddCategoryView.swift

import SwiftUI

struct AddCategoryView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: ExpenseViewModel

    @State private var categoryName = ""
    @State private var iconName = "questionmark"
    @State private var isIconPickerPresented = false

    // Kendi ikon listen — buraya daha fazla ikon ekleyebilirsin
    private let availableIcons = [
        "house", "heart", "car", "book", "paintpalette", "gift", "globe"
    ]

    var body: some View {
        NavigationStack {
            ZStack{
                Color("bgColor")
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    TextField("Category Name", text: $categoryName)
                        .padding()
                        .background(Color("bgColor"))
                        .cornerRadius(8)
                        .shadow(radius: 3)

                    Button {
                        isIconPickerPresented = true
                    } label: {
                        HStack {
                            Image(systemName: iconName)
                            Text("Choose Icon")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color("bgColor"))
                        .cornerRadius(8)
                        .shadow(radius: 2)
                    }

                    MyButton(text: "Add Category") {
                        guard !categoryName.isEmpty else { return }
                        viewModel.addUserCategory(icon: iconName, name: categoryName)
                        dismiss()
                    }

                    Spacer()
                }
                .padding()
                .navigationTitle("New Category")
                .sheet(isPresented: $isIconPickerPresented) {
                    SFIconPickerView(icons: availableIcons, selectedIcon: $iconName)
                }
            }
            
        }
    }
}


struct SFIconPickerView: View {
    let icons: [String]
    @Binding var selectedIcon: String
    @Environment(\.dismiss) var dismiss

    let columns = [GridItem(.adaptive(minimum: 44))]

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(icons, id: \.self) { icon in
                        Image(systemName: icon)
                            .resizable()
                            .scaledToFit()
                            .padding(10)
                            .frame(width: 44, height: 44)
                            .background(selectedIcon == icon ? Color.blue.opacity(0.3) : Color.clear)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .onTapGesture {
                                selectedIcon = icon
                                dismiss()
                            }
                    }
                }
                .padding()
            }
            .navigationTitle("Select Icon")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
            }
        }
    }
}
