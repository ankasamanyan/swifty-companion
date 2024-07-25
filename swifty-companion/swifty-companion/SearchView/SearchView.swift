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
    var user: User?

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
        .navigationBarBackButtonHidden(true)
        .tint(.indigo)
        Image("searchDrawing")
                 .resizable()
                 .scaledToFit()
                 .frame(width: 420, height: 400)
                 .padding(.bottom, 50)
                 .opacity(0.87)
    }
}

#Preview {
    SearchView()
}
