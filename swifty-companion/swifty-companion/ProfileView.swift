import SwiftUI
import Kingfisher
import Charts

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
                    SkillChartView(skills: skills)
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

struct ProfileHeaderView: View {
    var user: User?

    var body: some View {
        VStack {
            if let user = user {
                Text(user.displayname)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.indigo)
                    .padding(.top, 5)

                Text("@\(user.login)")
                    .font(.title3)
                    .foregroundStyle(.gray)
                    .padding(.bottom, 5)
                
                LevelView(level: user.cursusUsers[1].level)
                    .padding(.bottom, 20)

                SectionView(title: "Email") {
                    Text("\(user.email)")
                        .font(.title3)
                        .foregroundStyle(.indigo.opacity(0.8))
                }

                SectionView(title: "Wallet Points") {
                    Text("\(user.wallet) ₳")
                        .font(.title3)
                        .foregroundStyle(.indigo.opacity(0.8))
                }
                SectionView(title: "Phone Number") {
                    Text("\(user.phone ?? "N/A")")
                        .font(.title3)
                        .foregroundStyle(.indigo.opacity(0.8))
                }
            }
        }
        .foregroundColor(.white)
    }
}

struct ProjectCarouselView: View {
    var projects: [Project]

    var body: some View {
        SectionView (title: "Projects") {
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
                    .font(.headline)
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

struct SkillChartView: View {
    var skills: [Skill]
    
    private func truncatedSkillName(_ name: String, length: Int) -> String {
          if name.count > length {
              let endIndex = name.index(name.startIndex, offsetBy: length)
              return String(name[..<endIndex]) + "..."
          }
          return name
      }
    
    var body: some View {
       let skillData = skills.map { ToyShape(type: $0.name, count: $0.level)}

       SectionView(title: "Skills") {
           Chart {
               ForEach(skillData) { skill in
                   BarMark(
                       x: .value("Skill", skill.type),
                       y: .value("Level", skill.count)
                   )
                   .annotation(position: .bottom, alignment: .leading) {
                       Text(truncatedSkillName(skill.type, length: 15))
                           .font(.caption)
                           .foregroundColor(.indigo)
                           .rotationEffect(.degrees(45), anchor: .leading)
                           .padding(.leading, 10)
                   }
                   .annotation(position: .top, alignment: .leading) {
                       Text( String(format: "%.2f", skill.count))
                           .foregroundColor(.indigo)
                           .font(.caption)
                       
                   }

               }
           }
           .chartXAxis(.hidden)
           .frame(height: 300)
        

       }
   }
}

struct ToyShape: Identifiable {
    var type: String
    var count: Double
    var id = UUID()
}

struct ProfileImageView: View {
    var imageUrl: String?

    var body: some View {
        if let imageUrl = imageUrl {
            KFImage(URL(string: imageUrl))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 150, height: 150)
                .clipShape(Circle())
                .padding()
        } else {
            Image("catto")
                .resizable()
                .foregroundColor(.indigo)
                .aspectRatio(contentMode: .fill)
                .frame(width: 150, height: 150)
                .clipShape(Circle())
                .padding()
        }
    }
}

struct LevelView: View {
    var level: Double

    var body: some View {
        VStack {
            ZStack {
                ProgressView(value: level.truncatingRemainder(dividingBy: 1))
                    .scaleEffect(x: 1, y: 10, anchor: .center)
                    .progressViewStyle(LinearProgressViewStyle(tint: .indigo))
                    .frame(width: 350, height: 40)
                    .background(Color.indigo.opacity(0.5))
                    .cornerRadius(20)

                Text("Level: \(String(format: "%.2f", level))")
                    .foregroundColor(.white)
                    .font(.title2)
                    .bold()
            }
            .padding()
        }
    }
}

struct SectionView<Content: View>: View {
    var title: String
    var content: Content
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .foregroundColor(.gray)
                .padding(.bottom, 2)
            content
            Divider()
                .padding(.vertical, 5)
        }
        .padding(.horizontal)
    }
}

#Preview {
    ProfileView()
}
