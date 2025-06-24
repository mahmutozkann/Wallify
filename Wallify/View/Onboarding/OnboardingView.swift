//
//  OnboardingView.swift
//  Wallify
//
//  Created by Mahmut Özkan on 23.12.2024.
//

import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject var session: SessionManager
    var body: some View {
        TabView{
            OnboardingOne()
            OnboardingTwo()
            OnboardingThree(action: session.completeOnboarding)
        }
        .ignoresSafeArea()
        .tabViewStyle(.page)
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        
    }
}

#Preview {
    OnboardingView()
        .environmentObject(SessionManager())
}


struct OnboardingOne: View {
    var body: some View {
        GeometryReader { geometry in
            VStack{
                
                Spacer(minLength: geometry.size.height * 0.1)
                
                Image("onboarding1")
                    .resizable()
                    .scaledToFit()
                
                HStack{
                    Text("Welcome To")
                        .font(.largeTitle)
                        .bold()
                    Text("Wallify")
                        .font(.largeTitle)
                        .foregroundStyle(Color.myBlue)
                        .italic()
                        .bold()
                }
                
                Spacer()
                
                Text("Take Control of Your Finances")
                    .font(.system(size: 20))
                    .foregroundStyle(.linearGradient(Gradient(colors: [Color.myBlue, Color.red]), startPoint: .leading, endPoint: .trailing))
                
                Spacer()
            }
            
        }
        .ignoresSafeArea()
        .background(Color.gray)
    }
}

#Preview {
    OnboardingOne()
}

struct OnboardingTwo: View {
    var body: some View {
        GeometryReader { geometry in
            VStack{
                
                Spacer(minLength: geometry.size.height * 0.1)
                
                Image("onboarding2")
                    .resizable()
                    .scaledToFit()
                
                Text("Your Financal Journey Starts Here")
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                    .bold()
                    
                
                Spacer()
                
                Text("Track your expenses effortlessly and gain insights into your spending habits. Wallify makes budgeting simple, smart, and stress-free.")
                    .font(.system(size: 20))
                    .multilineTextAlignment(.center)
                    .fontWeight(.thin)
                    
                    
                
                Spacer()
            }
            
        }
        .ignoresSafeArea()
        .background(Color.gray)
    }
}

#Preview {
    OnboardingTwo()
}


struct OnboardingThree: View {
    let action: () -> Void
    
    var body: some View {
        GeometryReader { geometry in
            VStack{
                
                Spacer(minLength: geometry.size.height * 0.1)
                
                Image("onboarding3")
                    .resizable()
                    .scaledToFit()
                
                Text("Visualize Your Spending 💸")
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                    .bold()
                    
                
                Spacer(minLength: geometry.size.height * 0.1)
                
                Text("See where your money goes with clear, intuitive charts. Gain a deeper understanding of your finances at a glance.")
                    .font(.system(size: 20))
                    .multilineTextAlignment(.center)
                    .fontWeight(.thin)
                
                MyButton(text: "Done", action: action)
                    
                Spacer()
            }
            
        }
        .ignoresSafeArea()
        .background(Color.gray)
    }
    
    
}

func printAction() {
    print("action")
}

#Preview {
    OnboardingThree(action: printAction)
       
}
