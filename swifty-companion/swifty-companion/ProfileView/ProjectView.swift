//
//  ProjectView.swift
//  swifty-companion
//
//  Created by Anait Kasamanian on 13.07.24.
//

import Foundation
import SwiftUI

struct ProjectCarouselView: View {
    var projects: [ProjectsUser]

    var body: some View {
        SectionView(title: "Projects") {
            ScrollView(.vertical) {
                VStack(spacing: 10) {
                    ForEach(projects) { projectUser in
                        ProjectView(projectUser: projectUser)
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
        .padding(.vertical)
        .scrollTargetBehavior(.viewAligned)
    }
}

struct ProjectView: View {
    var projectUser: ProjectsUser

    var body: some View {
        ZStack(alignment: .leading) {
            Color.pink.opacity(0.15)
            
            LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.5), Color.indigo.opacity(0.9)]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .opacity(0.8)

            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Image(systemName: "star")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.yellow)
                        
                        Text(projectUser.project.name)
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.white)
                    }
                    Divider()
                    if let status = projectUser.status {
                        HStack {
                            Image(systemName: "timer")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.white).opacity(0.8)
                            Text("\(statusDescription(for: status))")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.white).opacity(0.8)
                                .padding(.leading, 3)
                        }
                        .padding(.leading, 3)
                    }
                    
                }
                    if let finalMark = projectUser.finalMark {
                        HStack {
                            Spacer()
                            Text("\(finalMark)")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.white)
                                .padding()
                                .overlay(Circle().stroke(
                                    LinearGradient(gradient: Gradient(colors: [Color.indigo.opacity(0.9), Color.blue.opacity(0.5), Color.green.opacity(0.7)]),
                                                   startPoint: .topLeading,
                                                   endPoint: .bottomTrailing), lineWidth: 3))
                        }
                        .padding(.leading, 10)
                    }
            }
            .padding(.vertical)
            .padding(.horizontal, 20)
            
            Pattern42()
                .opacity(0.1)
        }
        .frame(height: 130)
        .clipShape(RoundedRectangle(cornerRadius: 25))
    }

    private func statusDescription(for status: Status) -> String {
        switch status {
        case .finished:
            return "Finished"
        case .inProgress:
            return "In Progress"
        case .parent:
            return "Parent"
        case .searchingAGroup:
            return "Searching for a Group"
        case .waitingForCorrection:
            return "Waiting for Evaluation"
        case .creatingGroup:
            return "Creating a Group"
        }
    }
}

#Preview {
    ProjectCarouselView(projects: [])
}
