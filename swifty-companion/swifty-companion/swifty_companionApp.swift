//
//  swifty_companionApp.swift
//  swifty-companion
//
//  Created by Anait Kasamanian on 17.06.24.
//

import SwiftUI
import OAuthSwift

@main
struct swifty_companionApp: App {
    var body: some Scene {
        WindowGroup {
           LoginView()
                .onOpenURL(perform: { url in
                    OAuthSwift.handle(url: url)
                })
        }
    }
}
