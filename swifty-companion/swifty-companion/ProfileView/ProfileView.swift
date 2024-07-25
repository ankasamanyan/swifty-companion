import SwiftUI

struct ProfileView: View {
    var user: User?
    @State private var errorMessage: String?

    var body: some View {
        ScrollView {
            VStack {
                ProfileImageView(imageUrl: user?.image.link)
                    .padding(.top, 20)
                ProfileHeaderView(user: user)

                if let skills = user?.cursusUsers[1].skills {   // plz fix this at some point
                    SkillView(skills: skills)
                }

                if let projectsUsers = user?.projectsUsers {
                    ProjectCarouselView(projects: projectsUsers)
                }
                Spacer()
            }
        }
        .navigationTitle("Profile")
    }
}


#Preview {
    ProfileView()
}
