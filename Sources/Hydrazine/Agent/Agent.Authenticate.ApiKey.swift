//
//  Agent.Authenticate.swift
//  Hydrazine
//
//  Created by Hugh on 15/6/2025.
//
import Foundation

extension UnauthenticatedAgent {
    
    /// Return an `Authentication.Result` describing whether or not the
    /// supplied `Authentication.Token` does authenticate this `Agent`.
    public func authenticate<C: ProvidesConfiguration, S: ProvidesSession>(
        with token: Authentication.Token,
        configuration: C,
        session: S
    ) async throws(HydrazineError) -> Authentication.Result {
        
        let payload = AuthenticationPayloadApiKey(
            session_id: token.sessionId,
            hmac_bytes: tupleToBase64(token.hmac),
            time_hmac_computed: Int(token.timeHmacComputed)
        )
        
        let result: Authentication.Result = try await Request.make(
            configuration: configuration,
            path: authPathApiKey,
            method: .POST,
            queryItems: [],
            requestBody: payload,
            session: session
        )
        
        return result
        
    }
    
    
    /// Return an `Authentication.Result` describing whether or not the
    /// supplied `Authentication.Token` does authenticate this `Agent`.
    public func authenticate<O>(
        with token: Authentication.Token,
        context: O
    ) async throws(HydrazineError) -> Authentication.Result
    where O: ProvidesConfiguration, O: ProvidesSession {
        
        let payload = AuthenticationPayloadApiKey(
            session_id: token.sessionId,
            hmac_bytes: tupleToBase64(token.hmac),
            time_hmac_computed: Int(token.timeHmacComputed)
        )
        
        let result: Authentication.Result = try await Request.make(
            configuration: context,
            path: authPathApiKey,
            method: .POST,
            queryItems: [],
            requestBody: payload,
            session: context
        )
        
        return result
        
    }
    
    
}

public struct Authentication {
    
    /// Whether or not an authentication attempt did authenticate an
    /// ``Agent``.
    public struct Result: Decodable, Sendable {
        
        public let code: Code
        public let agentId: Int?
        
        private enum CodingKeys: String, CodingKey {
            case code
            case agentId = "agent_id"
        }
        
        public enum Code: UInt8, Decodable, Sendable {
            case success = 0
            case failure = 1
        }
        
    }
    
    public struct Token: Sendable {
        
        /// The ID of the `Session` whose API key signed the HMAC
        public let sessionId: String
        
        /// The time in integer seconds since the unix epoch at which the
        /// associated HMAC was computed, according to unauthenticated
        /// ``Agent``
        public let timeHmacComputed: UInt32
        
        /// The 64-bit Hashed Message Authentication Code provided by the
        /// unauthenticated ``Agent``
        public let hmac: HMACTuple
        
        public init(
            sessionId: String,
            timeHmacComputed: UInt32,
            hmac: HMACTuple
        ) {
            self.sessionId = sessionId
            self.timeHmacComputed = timeHmacComputed
            self.hmac = hmac
        }
        
        public typealias HMACTuple = (
            UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8
        )
        
    }
    
}


fileprivate let authPathApiKey = "/agent/authenticate/api-key"
fileprivate let authPathSteamTicket = "/agent/authenticate/steam-ticket"

fileprivate struct AuthenticationPayloadApiKey: Encodable {
    
    let session_id: String
    let hmac_bytes: String
    let time_hmac_computed: Int
    
}

fileprivate struct AuthenticationPayloadSteamTicket: Encodable {
    
    let agent_id: Int
    let steam_ticket: String
    
}

fileprivate struct AuthenticationResultPayload: Decodable {
    
    let result: Authentication.Result
    
}


fileprivate func tupleToBase64(
    _ t: Authentication.Token.HMACTuple
) -> String {

    let byteArray: [UInt8] = [t.0, t.1, t.2, t.3, t.4, t.5, t.6, t.7]
    
    let data = Data(byteArray)

    // 8 bytes -> 12 Base-64 characters such as "EjRWeJCrze8="
    return data.base64EncodedString()

}
