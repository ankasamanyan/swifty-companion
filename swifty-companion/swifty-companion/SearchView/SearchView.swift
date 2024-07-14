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
                 .frame(width: 420, height: 400)
                 .padding(.bottom, 50)
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

#Preview {
    SearchView()
}
