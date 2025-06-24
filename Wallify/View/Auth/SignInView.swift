//
//  SignInView.swift
//  Wallify
//
//  Created by Mahmut Özkan on 25.12.2024.
//

import SwiftUI
import Neumorphic

struct SignInView: View {
    @AppStorage("isLoggedIn") var isLoggedIn = false
    @State private var name = ""
    @State private var surname = ""
    @State private var password = ""
    @State private var email = ""
    let forgotPassword = "Forgot Password?"
    @State private var signUp = false
    @State private var wrongInputs = false
    @State private var showResetPasswordAlert = false
    @State private var resetAlertMessage = ""
    @State private var showResetConfirmation = false
    @State private var guestAlert = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("bgColor")
                    .ignoresSafeArea()
                
                GeometryReader{ geo in
                    
                    ScrollView {
                        VStack{
                            Spacer()
                            
                            Image("WallifyIcon")
                                .resizable()
                                .scaledToFit()
                                .frame(width: geo.size.width * 0.75, height: geo.size.height * 0.25)
                            
                            Text("Welcome To Wallify")
                                .font(.largeTitle)
                                .foregroundStyle(.myBlue)
                            
                            VStack{
                                
                                TextField("Email", text: $email)
                                    .keyboardType(.emailAddress)
                                    .autocapitalization(.none)
                                    .disableAutocorrection(true)
                                    .neumorphicTextField(height: geo.size.height * 1)
                                
                                SecureField("Password", text: $password)
                                    .neumorphicTextField(height: geo.size.height * 1)
                                    .padding(.top, 16)
                                
                                Text(forgotPassword)
                                    .italic()
                                    .foregroundStyle(.myBlue)
                                    .padding(.leading, geo.size.width * 0.4)
                                    .onTapGesture {
                                        if email.isEmpty {
                                            resetAlertMessage = "Please enter your email address first."
                                            showResetConfirmation = true
                                        } else {
                                            let userViewModel = UserViewModel()
                                            userViewModel.sendPasswordReset(email: email) { success, error in
                                                if success {
                                                    resetAlertMessage = "Password reset email has been sent."
                                                } else {
                                                    resetAlertMessage = error ?? "Something went wrong."
                                                }
                                                showResetConfirmation = true
                                            }
                                        }
                                    }
                                
                            }
                            .padding()
                            
                            MyButton(text: "Sign In") {
                                print("Sign In")
                                signIn(email: email, password: password){success in
                                    if success{
                                        isLoggedIn = true
                                    }else{
                                        wrongInputs = true
                                    }
                                }
                                
                            }
                            .disabled(email.isEmpty || password.isEmpty)
                            
                            
                            //                            Divider()
                            //                                .foregroundStyle(.black)
                            
                            Button {
                                signUp = true
                            } label: {
                                Text("Don't have an account?")
                                    .foregroundStyle(.blue)
                            }
                            
                            HStack {
                                Rectangle()
                                    .fill(Color.gray.opacity(0.4))
                                    .frame(height: 1)
                                
                                Text("OR")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                    .padding(.horizontal)
                                
                                Rectangle()
                                    .fill(Color.gray.opacity(0.4))
                                    .frame(height: 1)
                            }
                            .padding(.horizontal)
                            
                            MyButton(text: "Continue As Guest") {
                                signInAsGuest { success in
                                    if success {
                                        isLoggedIn = true
                                    }
                                    else{
                                        guestAlert = true
                                    }
                                }
                            }
                            .padding(.top, 8)
                        }
                        
                    }
                    .padding()
                }
                .ignoresSafeArea(.keyboard, edges: .bottom)
                .navigationDestination(isPresented: $signUp) {
                    SignUpView()
                }
                .overlay {
                    MyAlert(title: "Wrong Inputs", message: "Your email or password is not correct!", buttonText: "Ok", action: {
                        email = ""
                        password = ""
                    }, isPresented: $wrongInputs)
                }
                .alert(isPresented: $showResetConfirmation) {
                    Alert(title: Text("Password Reset"), message: Text(resetAlertMessage), dismissButton: .default(Text("OK")))
                }
                .alert(isPresented: $guestAlert){
                    Alert(title: Text("Internet Error"), message: Text("Guest Authentication Failed"), dismissButton: .default(Text("OK")))
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    SignInView()
}
