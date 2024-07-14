//
//  SectionView.swift
//  swifty-companion
//
//  Created by Anait Kasamanian on 13.07.24.
//

import Foundation
import SwiftUI

struct SectionView<Content: View>: View {
    var title: String
    var content: Content
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .foregroundColor(.gray)
                .padding(.bottom, 2)
            content
            Divider()
                .padding(.vertical, 5)
        }
        .padding(.horizontal)
    }
}
