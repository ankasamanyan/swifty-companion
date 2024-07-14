//
//  ProfileImageView.swift
//  swifty-companion
//
//  Created by Anait Kasamanian on 13.07.24.
//

import Foundation
import SwiftUI
import Kingfisher

struct ProfileImageView: View {
    var imageUrl: String?

    var body: some View {
        if let imageUrl = imageUrl {
            KFImage(URL(string: imageUrl))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 150, height: 150)
                .clipShape(Circle())
                .padding()
        } else {
            Image("catto")
                .resizable()
                .foregroundColor(.indigo)
                .aspectRatio(contentMode: .fill)
                .frame(width: 150, height: 150)
                .clipShape(Circle())
                .padding()
        }
    }
}
