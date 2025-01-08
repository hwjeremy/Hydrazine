//
//  Session.swift
//  HydrazineAPI
//
//  Created by Hugh on 2/1/2025.
//

import Foundation


/// An ``Agent`` associated with data sufficient for authentication
public struct Session: Decodable, Agent, Sendable, ProvidesSession,
                       Identifiable, Hashable, Equatable {
    
    internal static let path = "/session"
    internal static let headerIdName = "X-Session-ID"
    
    public let agentId: Int
    public let sessionId: String
    public let apiKey: String
    
    public var id: String { return self.sessionId }
    
    private enum CodingKeys: String, CodingKey {
        case agentId = "agent_id"
        case sessionId = "session_id"
        case apiKey = "api_key"
    }
    
    public init(agentId: Int, sessionId: String, apiKey: String) {
        self.agentId = agentId
        self.sessionId = sessionId
        self.apiKey = apiKey
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.sessionId)
    }
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.sessionId == rhs.sessionId
    }
    
}

/// Requirements for a type to be able to authenticate an ``Agent``
///
/// Hydrazine provides a ``Session`` type that conforms to `ProvidesSession`,
/// but you can define your own types with such conformance to suit the
/// needs of your application.
public protocol ProvidesSession {
    
    var agentId: Int { get }
    var sessionId: String { get }
    var apiKey: String { get }
    
}
