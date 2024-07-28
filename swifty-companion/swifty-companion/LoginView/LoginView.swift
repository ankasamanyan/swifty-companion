//
//  LoginView.swift
//  swifty-companion
//
//  Created by Anait Kasamanian on 17.06.24.
//

import OAuthSwift
import SwiftUI

struct LoginView: View {
    @State private var user: User?
    @StateObject var oauth2Handler = OAuth2Handler()
    @State private var navigateToDetail = false
    @State private var errorMessage: String?

    var body: some View {
        NavigationStack {
            ZStack {
                Color.pink.opacity(0.42)
                    .ignoresSafeArea(.all)
                LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.5), Color.indigo]),
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)
                Pattern42()
                    .edgesIgnoringSafeArea(.all)
                    .opacity(0.2)
                
                VStack {
                    Text("Welcome to Swifty-Companion!")
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
                        oauth2Handler.doOAuth2Login()
                    }) {
                        Text("Log In With 42")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.indigo)
                            .padding(.horizontal, 70)
                            .padding(.vertical, 20)
                            .background(Color.white)
                            .clipShape(.capsule)
                        
                    }
                    .padding(.bottom, 50)
                }
                .padding()
            }
            .onReceive(oauth2Handler.$isAuthenticated) { isAuthenticated in
                if isAuthenticated {
                    navigateToDetail = true
                }
                fetchUserData()
            }
            .navigationDestination(isPresented: $navigateToDetail) {
                SearchView(myUser: user)
            }
        }
    }
        private func fetchUserData() {
            APIClient.shared.fetchMyUserData { result in
                switch result {
                case .success(let user):
                    self.user = user
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
}

#Preview {
    LoginView()
}
