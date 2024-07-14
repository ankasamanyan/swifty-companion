//
//  ProfileHeaderView.swift
//  swifty-companion
//
//  Created by Anait Kasamanian on 13.07.24.
//

import Foundation
import SwiftUI

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

                SectionView(title:  "Email") {
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
