//
//  SearchProfilePreview.swift
//  swifty-companion
//
//  Created by Anait Kasamanian on 25.07.24.
//

import SwiftUI
import Kingfisher

struct SearchProfilePreview: View {
    var user: UserPreview
    
    var body: some View {
        GroupBox {
            VStack(alignment: .leading) {
                HStack {
                    if let imageUrl = user.images.link, let url = URL(string: imageUrl) {
                        KFImage(url)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                            .padding(.trailing, 10)
                    } else {
                        Image(systemName: "person.circle")
                            .font(.system(size: 50))
                            .padding(.trailing, 10)
                    }
                    VStack(alignment: .leading) {
                        Text("\(user.name) \(user.surname)")
                        Text("@\(user.nickname)")
                            .font(.headline)
                    }
                    .font(.system(size: 25, weight: .semibold))
                }
                .padding(10)
                .frame(width: 300, alignment: .leading)
            }
        }
    }
}

//#Preview {
//    SearchProfilePreview(user: <#UserPreview#>)
//}
