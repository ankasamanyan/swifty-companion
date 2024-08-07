//
//  OAuth2Handler.swift
//  swifty-companion
//
//  Created by Anait Kasamanian on 17.06.24.
//

import OAuthSwift
import Foundation
import SwiftUI
import Security

class OAuth2Handler: ObservableObject {
    @Published var isAuthenticated = false
    var oauthswift: OAuth2Swift?
    
    init() {
        guard let plistPath = Bundle.main.path(forResource: "Credentials", ofType: "plist") else {
            fatalError("Credentials.plist file not found.")
        }
        guard let plistData = FileManager.default.contents(atPath: plistPath) else {
            fatalError("Unable to load plist file.")
        }
        do {
            let plistDictionary = try PropertyListSerialization.propertyList(from: plistData, options: [], format: nil) as? [String: Any]
            
            guard let clientID = plistDictionary?["CLIENT_ID"] as? String,
                  let clientSecret = plistDictionary?["CLIENT_SECRET"] as? String else {
                fatalError("clientID and/or secret not found in plist file.")
            }
            
            self.oauthswift = OAuth2Swift(
                consumerKey: clientID,
                consumerSecret: clientSecret,
                authorizeUrl: "https://api.intra.42.fr/oauth/authorize",
                accessTokenUrl: "https://api.intra.42.fr/oauth/token",
                responseType: "code"
            )
                
        } catch {
            fatalError("Error loading plist file: \(error)")
        }
    }

    func doOAuth2Login() {
        print("Starting OAuth2 login")
        oauthswift?.authorize(
            withCallbackURL: URL(string: "swiftycompanion://oauth-callback/intra")!,
            scope: "public",
            state: "42"
        ) { result in
            switch result {
            case .success(let (credential, _, _)):
                print("OAuth Token: \(credential.oauthToken)")
                self.saveToken(credential.oauthToken, refreshToken: credential.oauthRefreshToken, expiration: credential.oauthTokenExpiresAt)
                self.isAuthenticated = true
            case .failure(let error):
                print("OAuth Error: \(error.localizedDescription)")
            }
        }
    }

    
    private func saveToken(_ token: String, refreshToken: String, expiration: Date?) {
        let tokenData = Data(token.utf8)
        let refreshTokenData = Data(refreshToken.utf8)
        let expirationData = expiration?.timeIntervalSince1970

        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: "oauthToken",
            kSecValueData: tokenData
        ] as [String : Any]

        SecItemDelete(query as CFDictionary)

        SecItemAdd(query as CFDictionary, nil)

        let refreshQuery = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: "refreshToken",
            kSecValueData: refreshTokenData
        ] as [String : Any]
        
        SecItemDelete(refreshQuery as CFDictionary)
        SecItemAdd(refreshQuery as CFDictionary, nil)

        if let expirationTime = expirationData {
            let expirationQuery = [
                kSecClass: kSecClassGenericPassword,
                kSecAttrAccount: "expirationDate",
                kSecValueData: Data("\(expirationTime)".utf8)
            ] as [String : Any]
            
            SecItemDelete(expirationQuery as CFDictionary)
            SecItemAdd(expirationQuery as CFDictionary, nil)
        }
    }
    
    static func getToken() -> String? {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: "oauthToken",
            kSecReturnData: true,
            kSecMatchLimit: kSecMatchLimitOne
        ] as [String : Any]

        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)

        guard status == errSecSuccess else {
            return nil
        }

        guard let tokenData = item as? Data,
              let token = String(data: tokenData, encoding: .utf8) else {
            return nil
        }

        return token
    }

    static func getRefreshToken() -> String? {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: "refreshToken",
            kSecReturnData: true,
            kSecMatchLimit: kSecMatchLimitOne
        ] as [String : Any]

        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)

        guard status == errSecSuccess else {
            return nil
        }

        guard let tokenData = item as? Data,
              let token = String(data: tokenData, encoding: .utf8) else {
            return nil
        }

        return token
    }
    
    static func getTokenExpirationDate() -> Date? {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: "expirationDate",
            kSecReturnData: true,
            kSecMatchLimit: kSecMatchLimitOne
        ] as [String : Any]

        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)

        guard status == errSecSuccess else {
            return nil
        }

        guard let expirationData = item as? Data,
              let expirationString = String(data: expirationData, encoding: .utf8),
              let expirationTime = TimeInterval(expirationString) else {
            return nil
        }

        return Date(timeIntervalSince1970: expirationTime)
    }

    func refreshTokenIfNeeded(completion: @escaping (Bool) -> Void) {
        guard let refreshToken = OAuth2Handler.getRefreshToken(),
              let expirationDate = OAuth2Handler.getTokenExpirationDate() else {
            completion(false)
            return
        }

        if expirationDate < Date() {
            oauthswift?.renewAccessToken(withRefreshToken: refreshToken) { result in
                switch result {
                case .success(let (credential, _, _)):
                    self.saveToken(credential.oauthToken, refreshToken: credential.oauthRefreshToken, expiration: credential.oauthTokenExpiresAt)
                    completion(true)
                case .failure(let error):
                    print("Token refresh error: \(error.localizedDescription)")
                    completion(false)
                }
            }
        } else {
            completion(true)
        }
    }
}
