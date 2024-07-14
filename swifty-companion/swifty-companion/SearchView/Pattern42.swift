//
//  Pattern42.swift
//  swifty-companion
//
//  Created by Anait Kasamanian on 14.07.24.
//

import Foundation
import SwiftUI

struct Pattern42: View {
    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size
            let magnifyingGlassSize: CGFloat = 50

            Path { path in
                for x in stride(from: 0, to: size.width, by: magnifyingGlassSize) {
                    for y in stride(from: 0, to: size.height, by: magnifyingGlassSize) {
                        path.addRect(CGRect(x: x, y: y, width: magnifyingGlassSize, height: magnifyingGlassSize))
                    }
                }
            }
            .fill(ImagePaint(image: Image(systemName: "42.square.fill"), scale:  2))
            .foregroundColor(.white).opacity(0.5)
        }
    }
}
