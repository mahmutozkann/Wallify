import SwiftUI
import Neumorphic

struct MyTabView: View {
    @State private var selectedIndex: Int = 0
    
    private let items: [(icon: String, title: String)] = [
        ("house", "Home"),
        ("wallet.bifold", "Wallet"),
        ("plus.app", "Add Expense"),
        ("chart.pie", "Chart"),
        ("person.crop.square", "Profile")
    ]
    
    init() {
        // Sistem TabBar’ı gizle
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        ZStack {
            // ------------ İçerik Bölümü ------------
            TabView(selection: $selectedIndex) {
                HomeView(selectedIntex: $selectedIndex)
                    .tag(0)
                WalletView(selectedIndex: $selectedIndex)
                    .tag(1)
                AddExpenseView(selectedIndex: $selectedIndex)
                    .tag(2)
                ChartsView(selectedIndex: $selectedIndex)
                    .tag(3)
                ProfileView(viewModel: UserViewModel(), selectedIndex: $selectedIndex)
                    .tag(4)
            }
            
            // ------------ Özel TabBar ------------
            VStack {
                Spacer()
                
                HStack(spacing: 0) {
                    ForEach(items.indices, id: \.self) { idx in
                        let item = items[idx]
                        Button(action: {
                            selectedIndex = idx
                            let impactFeedback = UIImpactFeedbackGenerator(style: .light)
                             impactFeedback.impactOccurred()
                        }) {
                            VStack(spacing: 4) {
                                Image(systemName: item.icon)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 24, height: 24)
                                if !item.title.isEmpty {
                                    Text(item.title)
                                        .font(.caption2)
                                }
                            }
                            .foregroundStyle(selectedIndex == idx ? .purple : .gray)
                            .frame(maxWidth: .infinity)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(height: 50)// ← Figma’daki boyut
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color("bgColor"))
                        .softOuterShadow()
                )
                .padding(.horizontal)
                .padding(.bottom, 20)                                    // home-indicator üstüne boşluk
            }
            .ignoresSafeArea(edges: .bottom)
        }
    }
}

#Preview {
    MyTabView()
}
