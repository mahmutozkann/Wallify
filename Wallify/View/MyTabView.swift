import SwiftUI

struct MyTabView: View {
    @State private var selectedIndex: Int = 0
    
    init() {
        // Tab bar için background özelleştirmesi
        UITabBar.appearance().backgroundColor = UIColor.clear
        UITabBar.appearance().isTranslucent = true
    }
    
    var body: some View {
        ZStack {
            
            LinearGradient(
                gradient: Gradient(colors: [Color.white, Color.gray.opacity(0.2)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            // TabView
            TabView(selection: $selectedIndex) {
                Group {
                    HomeView()
                        .tabItem {
                            Label("Home", systemImage: "house")
                        }
                        .tag(0)
                    
                    WalletView()
                        .tabItem {
                            Label("Wallet", systemImage: "wallet.bifold")
                        }
                        .tag(1)
                    
                    AddExpenseView()
                        .tabItem {
                            Label("Add Expense", systemImage: "plus.app")
                        }
                        .tag(2)
                    
                    PieChartView()
                        .tabItem {
                            Label("Chart", systemImage: "chart.pie")
                        }
                        .tag(3)
                    
                    ProfileView(viewModel: UserViewModel())
                        .tabItem {
                            Label("Profile", systemImage: "person.crop.square")
                        }
                        .tag(4)
                }
            }
            .tint(.myBlue)
            .background(
                BlurView(style: .systemMaterial) // Bulanık arka plan
                    .ignoresSafeArea(edges: .bottom) // Alt kısımdaki tab bar için uygular
            )
        }
    }
}

#Preview {
    MyTabView()
}

/// Blur efektini sağlayan SwiftUI görünümü
struct BlurView: UIViewRepresentable {
    var style: UIBlurEffect.Style

    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: style))
        return view
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}
