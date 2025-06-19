//
//  Steam.SteamId.MapToAgent.swift
//  Hydrazine
//
//  Created by Hugh on 19/6/2025.
//

extension Steam.SteamId {
    
    /// Create a record of a Steam ID, associating it with the `Agent`
    /// represented by the session in `context`.
    ///
    /// This is effectively a one-shot mechanism for mapping a Steam ID to
    /// a Hydrazine Agent. A game client should call this method as soon
    /// as it can access Steamworks, if it already has a Hydrazine
    /// Session available.
    public static func create<O>(
        in context: O,
        steamTicketHex: String
    ) async throws(HydrazineError) -> Void
    where O: ProvidesConfiguration, O: ProvidesSession {
        
        return try await Self.create(
            configuration: context,
            session: context,
            steamTicketHex: steamTicketHex
        )
        
    }
    
    /// Create a record of a Steam ID, associating it with the `Agent`
    /// represented by the session in `session`.
    ///
    /// This is effectively a one-shot mechanism for mapping a Steam ID to
    /// a Hydrazine Agent. A game client should call this method as soon
    /// as it can access Steamworks, if it already has a Hydrazine
    /// Session available.
    public static func create<C: ProvidesConfiguration, S: ProvidesSession>(
        configuration: borrowing C,
        session: S,
        steamTicketHex: String
    ) async throws(HydrazineError) -> Void {
        
        let payload = Payload(steam_ticket_hex_string: steamTicketHex)
        
        try await Request.make(
            configuration: configuration,
            path: Steam.SteamId.path,
            method: .POST,
            requestBody: payload
        )
        
        return
        
    }
    
    private struct Payload: Encodable {
        
        let steam_ticket_hex_string: String
        
    }
    
}
