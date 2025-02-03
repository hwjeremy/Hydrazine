//
//  Session.AuthenticationServices.swift
//  HydrazineAPI
//
//  Created by Hugh on 2/1/2025.
//

#if canImport(AuthenticationServices)
import AuthenticationServices

extension Session {
    
    private static let appleIdPath = Self.path + "/apple-id"
    
    private struct CreatePayload: Encodable {
        let token: String
        let name: String?
    }
    
    public static func create<C: ProvidesConfiguration>(
        configuration: C,
        credential: ASAuthorizationAppleIDCredential,
        name: String? = nil
    ) async throws(HydrazineError) -> Self {
        
        if let name = name, name.count > 128 {
            throw HydrazineError(clientFacingFriendlyMessage: "Name too long")
        }
        
        guard let token = credential.identityToken else {
            throw HydrazineError(clientFacingFriendlyMessage: """
A supplied ASAuthorisationAppleIDCredential does not contain an Identity Token
""")
        }
        
        guard let tokenString = String(data: token, encoding: .utf8) else {
            throw HydrazineError(clientFacingFriendlyMessage: """
Could not convert Apple ID token to a string
""")
        }
        
        return try await Self.create(
            configuration: configuration,
            appleIdCredentialToken: tokenString,
            name: name
        )
        
    }
    
    internal static func create<C: ProvidesConfiguration>(
        configuration: C,
        appleIdCredentialToken tokenString: String,
        name: String? = nil
    ) async throws(HydrazineError) -> Self {
        
        let payload = CreatePayload(token: tokenString, name: name)
        
        let result: Self = try await Request.make(
            configuration: configuration,
            path: Self.appleIdPath,
            method: .POST,
            requestBody: payload,
            session: nil as Session?
        )

        return result
        
    }

}

#endif

