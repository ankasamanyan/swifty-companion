//
//  swifty_companionApp.swift
//  swifty-companion
//
//  Created by Anait Kasamanian on 17.06.24.
//

import SwiftUI
import OAuthSwift


class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        print("loooool")
        if url.host == "oauth-callback" {
            print("leeeeeeeel")
            OAuthSwift.handle(url: url)
            return true
        }
        return false
    }
}

@main
struct swifty_companionApp: App {
    var body: some Scene {
        WindowGroup {
           LoginView()
        }
    }
}
