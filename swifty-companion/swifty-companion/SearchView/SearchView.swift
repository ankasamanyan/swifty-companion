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
    @State private var users: [UserPreview] = []
    @State private var isLoading = false
    @State private var errorLoading = false
    var myUser: User?

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
                SearchField(searchText: $searchText, onSearchTextChanged: { newValue in
                    if !newValue.isEmpty {
                        fetchUsers(loginPrefix: newValue)
                    } else {
                        users = []
                    }
                })
            
                Spacer()
                if isLoading {
                    ProgressView()
                } else if errorLoading {
                    Text("Error loading data")
                        .foregroundColor(.red)
                } else if !users.isEmpty {
                    List(users) { user in
                        SearchProfilePreview(user: user)
                    }
                }
                else if !searchText.isEmpty && users.isEmpty {
                    Text("There is no such user")
                }
            }

            UserProfileView(user: myUser)
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

    private func fetchUsers(loginPrefix: String) {
        isLoading = true
        errorLoading = false
        APIClient.shared.fetchUsers(prefix: loginPrefix) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let fetchedUsers):
                    self.users = fetchedUsers
                case .failure:
                    self.errorLoading = true
                }
            }
        }
    }
}
