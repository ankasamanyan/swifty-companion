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
                VStack {
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
        .scrollTargetBehavior(.viewAligned)
    }
}

struct ProjectView: View {
    var projectUser: ProjectsUser

    var body: some View {
        ZStack {
            Color.pink.opacity(0.15)
            
            LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.5), Color.indigo.opacity(0.9)]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .opacity(0.8)
                .frame(height: 250)
                .cornerRadius(25)

            VStack(alignment: .leading) {
                Text(projectUser.project.name)
                    .font(.system(size: 25, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.top, 10)
//                    .padding(.leading, 10)

                if let status = projectUser.status {
                    Text("Status: \(statusDescription(for: status))")
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                        .padding(.top, 10)
//                        .padding(.leading, 10)
                }

                if let finalMark = projectUser.finalMark {
                    Text("Score: \(finalMark)")
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                        .padding(.top, 10)
//                        .padding(.leading, 10)
                }

                Spacer()
            }
            .padding()
            
            Pattern42()
                .opacity(0.1)
        }
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
