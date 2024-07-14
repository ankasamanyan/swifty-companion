//
//  File.swift
//  swifty-companion
//
//  Created by Anait Kasamanian on 14.07.24.
//

import Foundation
import SwiftUI

struct BackgroundGradient: View {
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.5), Color.indigo.opacity(0.8)]),
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
            .frame(height: 350)
            .clipShape(RoundedRectangle(cornerRadius: 30))
            .edgesIgnoringSafeArea(.top)
    }
}
