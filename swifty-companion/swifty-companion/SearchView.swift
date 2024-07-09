//
//  SearchView.swift
//  swifty-companion
//
//  Created by Anait Kasamanian on 08.07.24.
//

import SwiftUI
import Kingfisher

struct SearchView: View {
    @State private var searchText = ""
    @State private var user: User?
    @State private var errorMessage: String?

    var body: some View {
        ZStack(alignment: .topTrailing) {
            BackgroundGradient()
            Pattern42()
                .frame(height: 350)
                .clipShape(RoundedRectangle(cornerRadius: 25))
                .opacity(0.2)
                .edgesIgnoringSafeArea(.top)
            
            VStack(alignment: .leading) {
                SearchHeader()
                SearchField(searchText: $searchText)
                Spacer()
            }
            UserProfileView(user: user)
        }
        .onAppear {
            fetchUserData()
        }
        .navigationBarBackButtonHidden(true)
        .tint(.indigo)
        Image("searchDrawing")
                 .resizable()
                 .scaledToFit()
                 .frame(width: 400, height: 400)
                 .padding(.bottom, 42)
                 .opacity(0.87)

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

struct BackgroundGradient: View {
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.5), Color.indigo.opacity(0.8)]),
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
            .frame(height: 350)
            .clipShape(RoundedRectangle(cornerRadius: 30))
            .edgesIgnoringSafeArea(.top)
    }
}

struct SearchHeader: View {
    var body: some View {
        HStack {
            Text("Let's find your peers!")
                .padding(.vertical)
            Image(systemName: "magnifyingglass")
                .foregroundColor(.indigo.opacity(0.4))
                .padding(.horizontal, 15)
                .font(.system(size: 65)).bold()
        }
        .font(.system(size: 42).bold())
        .padding(.top, 90)
        .padding(.leading, 30)
        .foregroundColor(.white)
    }
}

struct SearchField: View {
    @Binding var searchText: String
    
    
    var body: some View {
        HStack {
            TextField("Search", text: $searchText)
                .padding(15)
                .padding(.horizontal, 15)
                .background(Color(.systemGray6))
                .clipShape(RoundedRectangle(cornerRadius: 20))
        }
        .padding(.horizontal, 25)
    }
}

struct UserProfileView: View {
    var user: User?
    
    var body: some View {
        HStack {
            Text("Hi, \(user?.login ?? "Intra user")!")
                .padding(.leading, 30)
                .font(.title)
                .foregroundColor(.indigo)
                .padding(.top, 20)
            Spacer()
            NavigationLink(destination: ProfileView()) {
                SearchProfileImageView(imageUrl: user?.image.link)
                    .padding(.trailing, 20)
                    .padding(.top, 20)
                   }
        }
    }
}

struct SearchProfileImageView: View {
    var imageUrl: String?
    
    var body: some View {
        if let imageUrl = imageUrl {
            KFImage(URL(string: imageUrl))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 42, height: 42)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 1))
                .padding()
        } else {
            Image(systemName: "person.circle.fill")
                .resizable()
                .foregroundColor(.white)
                .aspectRatio(contentMode: .fill)
                .frame(width: 42, height: 42)
                .padding()
        }
    }
}

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



#Preview {
    SearchView()
}
