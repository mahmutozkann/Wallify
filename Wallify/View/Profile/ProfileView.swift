//
//  ProfileView.swift
//  Wallify
//
//  Created by Mahmut Özkan on 26.12.2024.
//

import SwiftUI
import Neumorphic

struct ProfileView: View {
    @AppStorage("isLoggedIn") var isLoggedIn = false
    @ObservedObject var viewModel: UserViewModel
    @StateObject var expenseViewModel = ExpenseViewModel()
    @Binding var selectedIndex: Int
    @State private var exportedFile: ExportedFile? = nil
    
    @State private var isChangePasswordPresented = false
    @State private var newPassword: String = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        
        ZStack {
            
            Color("bgColor")
                .ignoresSafeArea()
            
            VStack{
                
                HeaderView(headerName: "Profile", selectedIndex: $selectedIndex, viewModel: expenseViewModel, exportedFile: $exportedFile)
                    .padding(.horizontal, 20)
                
                ProfileIconView()
                    .softOuterShadow()
                
                UsernameView(name: viewModel.name, surname: viewModel.surname)
                
                ProfileInfoRow(iconName: "envelope.fill", infoText: viewModel.email)
                
                ProfileInfoRow(iconName: "pencil", infoText: "Change Password")
                    .onTapGesture {
                           isChangePasswordPresented = true
                       }
                
                MyButton(text: "Log Out") {
                    viewModel.logOut()
                }
                .padding(.top, 16)
                
                Spacer()
                
            }
            
        }
        .onAppear {
            viewModel.fetchUserData()
        }
        .sheet(isPresented: $isChangePasswordPresented) {
            VStack(spacing: 20) {
                Text("Change Password")
                    .font(.headline)
                
                SecureField("New Password", text: $newPassword)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                
                Button("Update") {
                    viewModel.changePassword(newPassword: newPassword) { success, error in
                        isChangePasswordPresented = false // önce sheet kapanır
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            if success {
                                alertMessage = "Password successfully changed."
                            } else {
                                alertMessage = error ?? "An error occurred."
                            }
                            showAlert = true // sonra alert gösterilir
                        }
                    }
                }
                
                Button("Cancel") {
                    isChangePasswordPresented = false
                }
                .foregroundColor(.red)
            }
            .padding()
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Info"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
}

