//
//  SignInView.swift
//  Wallify
//
//  Created by Mahmut Özkan on 25.12.2024.
//

import SwiftUI

struct SignInView: View {
    @AppStorage("isLoggedIn") var isLoggedIn = false
    @State private var name = ""
    @State private var surname = ""
    @State private var password = ""
    @State private var email = ""
    let forgotPassword = "Forgot Password?"
    @State private var signUp = false
    @State private var wrongInputs = false

    var body: some View {
        NavigationStack {
            GeometryReader{ geo in
                
                ScrollView {
                    VStack{
                        Spacer()
                        
                        Image("signInChart")
                            .resizable()
                            .scaledToFit()
                            .frame(width: geo.size.width * 0.25, height: geo.size.height * 0.25)
                        
                        Text("Welcome To Wallify")
                            .font(.largeTitle)
                            .foregroundStyle(.myBlue)
                        
                        VStack{
                            
                            TextField("Email", text: $email)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .textContentType(.emailAddress)
                            
                            SecureField("Password", text: $password)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            
                            Text(forgotPassword)
                                .italic()
                                .foregroundStyle(.myBlue)
                                .padding(.leading, geo.size.width * 0.4)
                                .onTapGesture {
                                    //forgot password email sent
                                    print("Email sent!")
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
                        
                        
                        Divider()
                            .foregroundStyle(.black)
                        
                        Button {
                            print("Sign Up Page")
                            signUp = true
                        } label: {
                            Text("Don't have an account?")
                                .foregroundStyle(.blue)
                        }
                        
                    }
                    
                }
                .padding()
            }
            // .ignoresSafeArea()
            .background(Color.gray.opacity(0.2))
            .navigationDestination(isPresented: $signUp) {
                SignUpView()
            }
            .overlay {
                MyAlert(title: "Wrong Inputs", message: "Your email or password is not correct!", buttonText: "Ok", action: {
                    email = ""
                    password = ""
                }, isPresented: $wrongInputs)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    SignInView()
}
