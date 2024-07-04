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
        ScrollView {
            VStack {
                ZStack {
                    Color.indigo
                        .opacity(0.89)
                        .frame(height:400)
                        .clipShape(.rect(cornerRadius: 30))
                        .edgesIgnoringSafeArea(.top)
                    
                    VStack {
                        if let user = user {
                            if let imageUrl = user.image.link {
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
                            
                            Text("\(user.displayname)")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            
                            Text("@\(user.login)")
                                .font(.title3)
                                .foregroundStyle(.white.opacity(0.8))
                                .padding(5)
                            Text("✉️: \(user.email)")
                                .font(.title3)
                                .foregroundStyle(.white.opacity(0.8))
                            Text("Wallet points: \(user.wallet)")
                                .font(.title3)
                                .foregroundStyle(.white.opacity(0.8))
                           
                        }
                    }
                    .foregroundColor(.white)
                    .navigationBarBackButtonHidden(true)
                }
                .offset(y: -59)
                
                ZStack {
                    //progress bar for the lvl
                    Color(.indigo)
                        .opacity(0.89)
                        .frame(width: 380, height: 80)
                        .clipShape(.capsule)
                    VStack {
                        Text ("Level: \(String(format: "%.2f", user?.cursusUsers[1].level ?? 0.0))")
                            .foregroundColor(.white)
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    }
                    
                }
                .padding(.bottom, 20)
                
                HStack {
                    ZStack {
                        Color(.indigo)
                            .opacity(0.89)
                            .frame(width: 180, height: 100)
                            .clipShape(.rect(cornerRadius: 15))
                    }
                    
                    ZStack {
                        Color(.indigo)
                            .opacity(0.89)
                            .frame(width: 180, height: 100)
                            .clipShape(.rect(cornerRadius: 15))
                    }
                }
                .padding(.bottom, 20)
                
                ZStack {
                    Color(.indigo)
                        .opacity(0.89)
                        .frame(width: 370, height: 200)
                        .clipShape(.rect(cornerRadius: 15))
                }
                
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
    }
}

#Preview {
    ProfileView()
}
