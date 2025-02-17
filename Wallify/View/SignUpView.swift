//
//  SignUpView.swift
//  Wallify
//
//  Created by Mahmut Özkan on 25.12.2024.
//

import SwiftUI
import FirebaseAuth

struct SignUpView: View {
    @State private var name = ""
    @State private var surname = ""
    @State private var password = ""
    @State private var email = ""
    @State private var signIn = false
    
    
    var body: some View {
        NavigationStack{
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
                            
                            TextField("Name", text: $name)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            
                            TextField("Surname", text: $surname)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            
                            TextField("Email", text: $email)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .textContentType(.emailAddress)
                            
                            SecureField("Password", text: $password)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            
                        }
                        .padding()
                        
                        MyButton(text: "Sign Up") {
                            print("Sign Up")
                            //sign up progress
                            register(email: email, password: password, name: name, surname: surname){ success in
                                if success{
                                    signIn = true
                                }
                            }
                        }
                        .disabled(name.isEmpty || surname.isEmpty || email.isEmpty || password.isEmpty)
                        
                        
                        Divider()
                            .foregroundStyle(.black)
                        
                        Button {
                            print("Sign In Page")
                            signIn = true
                        } label: {
                            Text("Already have an account?")
                                .foregroundStyle(.blue)
                        }
                        
                        
                        Spacer()
                        
                    }
                    
                }
                .padding()
                
                
            }
           // .ignoresSafeArea()
            .background(Color.gray.opacity(0.2))
            .navigationDestination(isPresented: $signIn) {
                SignInView()
            }
            
        }
        .navigationBarBackButtonHidden(true)
        
    }
    
   
    
    
}

#Preview {
    SignUpView()
}
