//
//  LoginView.swift
//  swifty-companion
//
//  Created by Anait Kasamanian on 17.06.24.
//

import OAuthSwift
import SwiftUI

struct LoginView: View {
    var body: some View {
        ZStack {
            Color.indigo
                .opacity(0.97)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Welcome to Swifty Companion!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top, 90)
                
                Spacer()
                Image("computerGirl")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 350, height: 350)
                
                Spacer()
                Button(action: {
                }) {
                    Text("Log In With 42")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.indigo)
                        .padding(.horizontal, 85)
                        .padding(.vertical, 15)
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(10)
                }
                .padding(.bottom, 50)
            }
            .padding()
        }
    }
}

#Preview {
    LoginView()
}
