//
//  swifty_companionApp.swift
//  swifty-companion
//
//  Created by Anait Kasamanian on 17.06.24.
//

import SwiftUI
import OAuthSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        if url.host == "oauth-callback" {
            OAuthSwift.handle(url: url)
        }
        return true
    }
}

struct swifty_companionApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

