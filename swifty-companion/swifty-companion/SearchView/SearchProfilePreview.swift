//
//  SearchProfilePreview.swift
//  swifty-companion
//
//  Created by Anait Kasamanian on 25.07.24.
//

import SwiftUI
import Kingfisher

struct SearchProfilePreview : View {
    var body: some View {
        GroupBox {
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "person.circle")
                        .font(.system(size: 50))
                        .padding(.trailing, 10)
                    VStack(alignment: .leading) {
                        Text("User Name")
                        Text("@intranme")
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

#Preview {
    SearchProfilePreview()
}
