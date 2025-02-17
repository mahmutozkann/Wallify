//
//  TestProfileView.swift
//  Wallify
//
//  Created by Mahmut Özkan on 6.01.2025.
//

import SwiftUI

struct TestProfileView: View {
    var body: some View {
        ZStack{
            LinearGradient(
                gradient: Gradient(colors: [Color.purple.opacity(0.6), Color.pink.opacity(0.6)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            VStack(spacing: 20) {
                // Profil resmi ve blur efekti
                ZStack {
                    
                    
                    Image("avatar")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 120, height: 120)
                        .clipShape(Circle())
                        .shadow(color: .black, radius: 10, x: 0, y: 10)
                }
                .padding(.top, 50)
                
                // Takipçi sayısı
                Text("24,978 Followers")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.white.opacity(0.7))
                
                // İsim
                Text("Angela Robinson")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.white)
                
                // Etiketler
                HStack(spacing: 10) {
                    TagView(text: "Coach")
                    TagView(text: "Architecture")
                    TagView(text: "Personal Growth")
                }
                
                // Alt bilgi
                VStack(spacing: 10) {
                    HStack(spacing: 40) {
                        InfoView(title: "Sessions", value: "2,378")
                        InfoView(title: "Age", value: "32 y.o")
                        InfoView(title: "Videos", value: "25,899")
                    }
                }
                .padding(.top, 20)
                
                Spacer()
            }
        }
    }
}

#Preview {
    TestProfileView()
}

// Etiket görünümü
struct TagView: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(.system(size: 14, weight: .medium))
            .padding(.vertical, 6)
            .padding(.horizontal, 12)
            .background(Color.white.opacity(0.2))
            .cornerRadius(12)
            .foregroundColor(.white)
    }
}

// Bilgi görünümü
struct InfoView: View {
    var title: String
    var value: String
    
    var body: some View {
        VStack {
            Text(value)
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.white)
            Text(title)
                .font(.system(size: 14))
                .foregroundColor(.white.opacity(0.7))
        }
    }
}
