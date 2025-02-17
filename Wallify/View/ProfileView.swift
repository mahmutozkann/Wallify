//
//  ProfileView.swift
//  Wallify
//
//  Created by Mahmut Özkan on 26.12.2024.
//

import SwiftUI

struct ProfileView: View {
    @AppStorage("isLoggedIn") var isLoggedIn = false
    @ObservedObject var viewModel: UserViewModel
    
    var body: some View {
        
        ZStack {
            
            LinearGradient(
                gradient: Gradient(colors: [Color.purple.opacity(0.6), Color.pink.opacity(0.6)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack(spacing: 20) {
                
//                ZStack {
//                    Image("avatar")
//                        .resizable()
//                        .scaledToFill()
//                        .frame(width: 120, height: 120)
//                        .clipShape(Circle())
//                        .shadow(color: .black, radius: 10, x: 0, y: 10)
//                }
//                .padding(.top, 50)
                
                ZStack {
                    Image("person")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 120, height: 120)
                        .clipShape(Circle())
                        .shadow(color: .black, radius: 10, x: 0, y: 10)
                }
                .padding(.top, 50)
                
                HStack {
                    Text(viewModel.name)
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.white)
                    Text(viewModel.surname)
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.white)
                }
                
                MyButton(text: "Log Out") {
                    viewModel.logOut()
                }
                
                Spacer()
                
            }
            
        }
        .onAppear {
            viewModel.fetchUserData()
        }
    }
}

#Preview {
    ProfileView(viewModel: UserViewModel())
}
