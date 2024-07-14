//
//  ProjectView.swift
//  swifty-companion
//
//  Created by Anait Kasamanian on 13.07.24.
//

import Foundation
import SwiftUI

struct ProjectCarouselView: View {
    var projects: [Project]

    var body: some View {
        SectionView(title: "Projects") {
            ScrollView(.vertical) {
                
                VStack {
                    ForEach(projects, id: \.name) { project in
                        ProjectView(project: project)
                            .scrollTransition { content, phase in
                                content
                                    .opacity(phase.isIdentity ? 1 : 0.5)
                                    .scaleEffect(phase.isIdentity ? 1 : 0.7)
                            }
                    }
                }
                .scrollTargetLayout()
            }
            .frame(height: 350)
        }
            .scrollTargetBehavior(.viewAligned)
    }
}

struct ProjectView: View {
    var project: Project

    var body: some View {
        ZStack {
            Color.pink.opacity(0.15)
            
            LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.5), Color.indigo.opacity(0.9)]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .opacity(0.8)
                .frame(height: 250)
            
            VStack {
                Text(project.name)
                    .font(.system(size: 20))
                    .foregroundColor(.white)
                    .padding(.bottom, 10)
            }
            .padding()
            
            Pattern42()
                .opacity(0.1)
        }
        .clipShape(RoundedRectangle(cornerRadius: 25))
        
    }
}
