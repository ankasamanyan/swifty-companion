//
//  SearchProfilePreview.swift
//  swifty-companion
//
//  Created by Anait Kasamanian on 25.07.24.
//

import SwiftUI
import Kingfisher

struct SearchProfilePreview: View {
    var user: UserPreview?
    
    var body: some View {
        GroupBox {
            HStack {
                if (user?.id != nil)
                {
                    NavigationLink(destination: ProfileView(userId: user?.id)) {
                        SearchProfileImageView(imageUrl: user?.images.link)
                    }
                }
                    VStack(alignment: .leading) {
                        Text("\(user?.name ?? "Catto") \(user?.surname ?? "Wiskerson")")
                        Text("@\(user?.nickname ?? "cwiskers")")
                            .font(.headline)
                    }
                    .font(.system(size: 20, weight: .semibold))
            }
            .frame(width: 300, alignment: .leading)
        }
    }

}
