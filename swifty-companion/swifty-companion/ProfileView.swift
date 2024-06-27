//
//  ProfileView.swift
//  swifty-companion
//
//  Created by Anait Kasamanian on 17.06.24.
//

import SwiftUI

struct ProfileView: View {
    @State private var user: User?
    @State private var errorMessage: String?
    
    var body: some View {
            VStack {
                ZStack {
                    Color.indigo
                        .opacity(0.89)
                        .frame(height:400)
                        .clipShape(.rect(cornerRadius: 30))
                        .edgesIgnoringSafeArea(.top)
                    
                    VStack {
                        Image("catto")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 150, height: 150)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 1))
                            .shadow(radius: 10)
                        
                        Text("Catto Whiskerson")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(5)
                        Text("@cwhiskers")
                            .font(.title3)
                            .foregroundStyle(.white.opacity(0.8))
                    }
                    .padding()
                    .offset(y: -30)
                }
                Spacer()
                .foregroundColor(.white)
                .navigationBarBackButtonHidden(true)
            }
        }
}

#Preview {
    ProfileView()
}
