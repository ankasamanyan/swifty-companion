//
import OAuthSwift
import Foundation
import SwiftUI
import Security

class OAuth2Handler: ObservableObject {
    @Published var isAuthenticated = false
    var oauthswift: OAuth2Swift?
    
    let clientID = Bundle.main.infoDictionary?["CLIENT_ID"] as? String ?? ""
    let clientSecret = Bundle.main.infoDictionary?["CLIENT_SECRET"] as? String ?? ""
    
    init() {
        self.oauthswift = OAuth2Swift(
            consumerKey: clientID,
            consumerSecret: clientSecret,
            authorizeUrl: "https://api.intra.42.fr/oauth/authorize",
            accessTokenUrl: "https://api.intra.42.fr/oauth/token",
            responseType: "code"
        )
        print("OAuth2Swift initialized with clientID: \(clientID), clientSecret: \(clientSecret)")
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

        // Delete any existing items
        SecItemDelete(query as CFDictionary)

        // Add the new keychain item
        SecItemAdd(query as CFDictionary, nil)

        // Save refresh token
        let refreshQuery = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: "refreshToken",
            kSecValueData: refreshTokenData
        ] as [String : Any]
        
        SecItemDelete(refreshQuery as CFDictionary)
        SecItemAdd(refreshQuery as CFDictionary, nil)

        // Save expiration date
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
