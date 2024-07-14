import SwiftUI

struct ProfileView: View {
    @State private var user: User?
    @State private var errorMessage: String?

    var body: some View {
        ScrollView {
            VStack {
                ProfileImageView(imageUrl: user?.image.link)
                    .padding(.top, 20)
                ProfileHeaderView(user: user)

                if let skills = user?.cursusUsers[1].skills {
                    SkillView(skills: skills)
                }

                if let projects = user?.projectsUsers.map({ $0.project }) {
                    ProjectCarouselView(projects: projects)
                }

                Spacer()
            }
            .onAppear {
                fetchUserData()
            }
        }
        .navigationTitle("Profile")
    }
    
    private func fetchUserData() {
        APIClient.shared.fetchMyUserData { result in
            switch result {
            case .success(let user):
                self.user = user
            case .failure(let error):
                print("\n There was an error here \n")
                self.errorMessage = error.localizedDescription
            }
        }
    }
}


#Preview {
    ProfileView()
}
