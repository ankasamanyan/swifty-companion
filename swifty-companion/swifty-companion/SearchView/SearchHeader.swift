//
//  SearchHeader.swift
//  swifty-companion
//
//  Created by Anait Kasamanian on 14.07.24.
//

import Foundation
import SwiftUI

struct SearchHeader: View {
    var body: some View {
        HStack {
            Text("Let's find your peers!")
                .padding(.vertical)
            Image(systemName: "magnifyingglass")
                .foregroundColor(.indigo.opacity(0.4))
                .padding(.horizontal, 15)
                .font(.system(size: 65)).bold()
        }
        .font(.system(size: 42).bold())
        .padding(.top, 70)
        .padding(.leading, 30)
        .padding(.bottom, 10)
        .foregroundColor(.white)
    }
}
