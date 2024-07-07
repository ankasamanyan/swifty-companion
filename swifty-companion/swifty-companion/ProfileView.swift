import SwiftUI
import Kingfisher

struct ProfileView: View {
    @State private var user: User?
    @State private var errorMessage: String?
    
    var body: some View {
        ScrollView {
            VStack {
                ProfileImageView(imageUrl: user?.image.link)
                    .padding(.top, 20)
                HeaderView(user: user)
//                SkillsView(user: user)
                
//                InfoView(user: user)
//                    .padding(.bottom, 20)
//                AdditionalInfoView()
                Spacer()
            }
            .onAppear {
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
        .navigationTitle("Profile")
    }
}

struct HeaderView: View {
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


//struct SkillsView: View {
//    var user
//}


//struct InfoView: View {
//    var user: User?
//    
//    var body: some View {
//        HStack {
//            InfoBox(text: "\(String(describing: user?.campus[0].name ?? ""))")
//            InfoBox(text: "Additional Info")
//        }
//    }
//}
//
//struct InfoBox: View {
//    var text: String
//    
//    var body: some View {
//        ZStack {
//            Color.white
//                .opacity(0.89)
//                .frame(width: 180, height: 100)
//                .clipShape(RoundedRectangle(cornerRadius: 15))
//                .shadow(radius: 10)
//            
//            Text(text)
//                .multilineTextAlignment(.center)
//                .foregroundColor(.black)
//        }
//    }
//}

//struct AdditionalInfoView: View {
//    var body: some View {
//        ZStack {
//            Color.white
//                .opacity(0.89)
//                .frame(width: 370, height: 200)
//                .clipShape(RoundedRectangle(cornerRadius: 15))
//                .shadow(radius: 10)
//        }
//    }
//}

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
