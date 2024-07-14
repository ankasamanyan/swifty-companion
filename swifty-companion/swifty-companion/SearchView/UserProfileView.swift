//
//  UserProfile.swift
//  swifty-companion
//
//  Created by Anait Kasamanian on 14.07.24.
//

import Foundation
import SwiftUI

struct UserProfileView: View {
    var user: User?
    
    var body: some View {
        HStack {
            Text("Hi, \(user?.login ?? "Intra user")!")
                .padding(.leading, 30)
                .font(.title2)
                .foregroundColor(.indigo)
                .padding(.top, 20)
            Spacer()
            NavigationLink(destination: ProfileView()) {
                SearchProfileImageView(imageUrl: user?.image.link)
                    .padding(.trailing, 20)
                    .padding(.top, 20)
                   }
        }
    }
}
