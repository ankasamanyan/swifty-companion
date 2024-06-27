//
//  DetailView.swift
//  swifty-companion
//
//  Created by Anait Kasamanian on 17.06.24.
//

import SwiftUI

struct DetailView: View {
    @State private var user: User?
    @State private var errorMessage: String?
    
    var body: some View {
            VStack {
                ZStack {
                    Color.indigo
                        .frame(height:400)
                        .edgesIgnoringSafeArea(.top)
                    
                    VStack {
                        Image("catto")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 150, height: 150)
                            .clipShape(Circle())
//                            .overlay(Circle().stroke(Color.white, lineWidth: 4))
                            .shadow(radius: 10)
                        
                        Text("Catto Catson")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                    }
                    .padding()
                }
                Spacer()
            }
        }
}

#Preview {
    DetailView()
}
