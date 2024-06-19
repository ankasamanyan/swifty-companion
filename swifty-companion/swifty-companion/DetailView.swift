//
//  DetailView.swift
//  swifty-companion
//
//  Created by Anait Kasamanian on 17.06.24.
//

import SwiftUI

struct DetailView: View {
    @State private var user: User?
    @State private var errorMessage: String?
    
    var body: some View {
        VStack {
            if let user = user {
                Text("Login: \(user.login)")
                Text("Email: \(user.email)")
                Text("Phone: \(user.phone ?? "N/A")")
                Text("Level: \(user.level)")
                Text("Location: \(user.location ?? "N/A")")
                Text("Wallet: \(user.wallet)")
                Text("Evaluation Points: \(user.evaluationPoints)")
                // Display other user details here
                List(user.skills, id: \.name) { skill in
                    VStack(alignment: .leading) {
                        Text(skill.name)
                        Text("Level: \(skill.level)")
                    }
                }
                List(user.projectsUsers, id: \.project.name) { projectUser in
                    VStack(alignment: .leading) {
                        Text(projectUser.project.name)
                        Text("Status: \(projectUser.status)")
                    }
                }
            } else if let errorMessage = errorMessage {
                Text(errorMessage)
            } else {
                ProgressView()
            }
        }
        .onAppear {
            APIClient.shared.fetchUserData { result in
                switch result {
                case .success(let user):
                    self.user = user
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
        .navigationTitle("Details")
    }
}

#Preview {
    DetailView()
}
