//
//  ProfileView.swift
//  swifty-companion
//
//  Created by Anait Kasamanian on 17.06.24.
//

import SwiftUI

struct ProfileView: View {
    @State private var errorMessage: String?
    @State private var isLoading = false
    @State private var errorLoading = false
    @State private var fetchedUser: User?
    @State private var hasFetchedUser = false
    var user: User?
    var userId: Int?

    var body: some View {
        ScrollView {
            if isLoading {
                ProgressView()
            } else if errorLoading {
                Text("Error loading data: \(errorMessage ?? "Unknown error")")
                    .foregroundColor(.red)
            } else {
                VStack {
                    ProfileImageView(imageUrl: (fetchedUser ?? user)?.image.link)
                        .padding(.top, 20)
                    ProfileHeaderView(user: fetchedUser ?? user)

                    if let fetchedUser = fetchedUser ?? user,
                       fetchedUser.cursusUsers.indices.contains(1) {
                        SkillView(skills: fetchedUser.cursusUsers[1].skills)
                    } else {
                        if ((fetchedUser?.cursusUsers.indices.contains(0)) != nil) {
                            SkillView(skills: (fetchedUser?.cursusUsers[0].skills)!)
                        } else {
                            Text("No skills available")
                                .foregroundColor(.gray)
                        }
                    }

                    if let projectsUsers = (fetchedUser ?? user)?.projectsUsers {
                        ProjectCarouselView(projects: projectsUsers)
                    }
                    Spacer()
                }
                .onAppear {
                    if userId != nil && !hasFetchedUser {
                        fetchUserById()
                    }
                }
            }
        }
        .navigationTitle("Profile")
    }
    
    private func fetchUserById() {
        guard let userId = userId else { return }
        isLoading = true
        errorLoading = false

        APIClient.shared.fetchUserById(userId: userId) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let fetchedUser):
                    self.fetchedUser = fetchedUser
                    self.hasFetchedUser = true
                case .failure(let error):
                    self.errorLoading = true
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
