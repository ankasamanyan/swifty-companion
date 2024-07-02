//
//  ProfileView.swift
//  swifty-companion
//
//  Created by Anait Kasamanian on 17.06.24.
//

import SwiftUI
import Kingfisher

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
                        if let user = user {
                            if let imageUrl = user.image?.link {
                                KFImage(URL(string: imageUrl))
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 150, height: 150)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color.white, lineWidth: 1))
                                    .shadow(radius: 10)
                            } else {
                                Image(systemName: "person.circle")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 150, height: 150)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color.white, lineWidth: 1))
                                    .shadow(radius: 10)
                            }
                            
                            Text("\(user.usualFullName)")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(5)
                            
                            Text("@\(user.login)")
                                .font(.title3)
                                .foregroundStyle(.white.opacity(0.8))
                    }
                }
                    .foregroundColor(.white)
                    .navigationBarBackButtonHidden(true)
            }
            .offset(y: -30)
            Spacer()
        }
        .onAppear {
            APIClient.shared.fetchUserData { result in
                switch result {
                case .success(let user):
                    self.user = user
                case .failure(let error):
                    print("\n There was an error here \n")
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    private struct sizes{
        static let maxHeight: CGFloat = 60
        static let maxWidth: CGFloat = 40
    }
}

#Preview {
    ProfileView()
}
