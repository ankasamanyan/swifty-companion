//
//  SearchView.swift
//  swifty-companion
//
//  Created by Anait Kasamanian on 08.07.24.
//

import SwiftUI
import Kingfisher

struct SearchView: View {
    @StateObject private var viewModel = SearchViewModel()
    var myUser: User

    var body: some View {
        ZStack(alignment: .topTrailing) {
            BackgroundGradient()
                .frame(height: 450)
                .clipShape(RoundedRectangle(cornerRadius: 25))
                .edgesIgnoringSafeArea(.all)
            Pattern42()
                .frame(height: 450)
                .clipShape(RoundedRectangle(cornerRadius: 25))
                .opacity(0.2)
                .edgesIgnoringSafeArea(.all)

            Image("searchDrawing")
                .resizable()
                .scaledToFit()
                .frame(width: 420, height: 400)
                .padding(.top, 350)
                .opacity(0.87)

            VStack(alignment: .leading) {
                SearchHeader()
                SearchField(searchText: $viewModel.searchText)

                if viewModel.users.isEmpty {
                    Spacer()
                }

                if viewModel.isLoading {
                    Spacer()
                    ProgressView()
                } else if viewModel.errorLoading {
                    Spacer()
                    Text("Error loading data")
                        .foregroundColor(.red)
                } else if !viewModel.users.isEmpty {
                    List(viewModel.users) { user in
                        SearchProfilePreview(user: user)
                    }
                    .padding(.top, 30)
                } else if !viewModel.searchText.isEmpty && viewModel.users.isEmpty {
                    SearchProfilePreview(user: nil)
//                    GroupBox {
//                        HStack {
//                                SearchProfileImageView(imageUrl: nil)
//                                VStack(alignment: .leading) {
//                                    Text ("Catto Wiskerson")
//                                    Text("@cwiskers")
//                                        .font(.headline)
//                                }
//                                .font(.system(size: 20, weight: .semibold))
//                        }
//                        .frame(width: 300, alignment: .leading)
//                    }
//                    .padding(.top, 30)
                    Spacer()
                }
            }
            .padding(.horizontal, 15)

            LoggedInUserPreview(user: myUser)
                .padding(.horizontal, 15)
        }
        .navigationBarBackButtonHidden(true)
        .tint(.indigo)
    }
}
