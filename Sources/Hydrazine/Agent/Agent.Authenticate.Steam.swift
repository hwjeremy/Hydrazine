//
//  Agent.Authenticate.Steam.swift
//  Hydrazine
//
//  Created by Hugh on 15/6/2025.
//
import Foundation

extension UnauthenticatedAgent {
    
    public func authenticate<C: ProvidesConfiguration>(
        with ticket: SteamTicket,
        configuration: C
    ) async throws(HydrazineError) -> Authentication.Result {
        
        let payload = AuthenticationPayload(
            agent_id: Int(self.agentId),
            steam_ticket: ticket.ticket
        )
        
        let result: Authentication.Result = try await Request.make(
            configuration: configuration,
            path: authPath,
            method: .POST,
            queryItems: [],
            requestBody: payload,
            session: nil as (Session?)
        )
        
        return result
        
    }
    
}


public struct SteamTicket {
    
    let ticket: String
    
}


fileprivate let authPath = "/agent/authenticate/steam-ticket"

fileprivate struct AuthenticationPayload: Encodable {
    
    let agent_id: Int
    let steam_ticket: String
    
}

