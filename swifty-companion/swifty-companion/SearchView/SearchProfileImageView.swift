//
//  SearchProfileImageView.swift
//  swifty-companion
//
//  Created by Anait Kasamanian on 14.07.24.
//

import Foundation
import SwiftUI
import Kingfisher

struct SearchProfileImageView: View {
    var imageUrl: String?
    
    var body: some View {
        if let imageUrl = imageUrl {
            KFImage(URL(string: imageUrl))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 42, height: 42)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 1))
                .padding()
        } else {
            Image(systemName: "person.circle.fill")
                .resizable()
                .foregroundColor(.white)
                .aspectRatio(contentMode: .fill)
                .frame(width: 42, height: 42)
                .padding()
        }
    }
}
